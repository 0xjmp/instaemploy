require 'securerandom'

class User < ActiveRecord::Base
  has_merit

  include DateHelper

  validates_presence_of :first_name, :last_name, :username
  validates_uniqueness_of :username

  before_save :ensure_auth_token
  after_create :send_welcome_email

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable

  acts_as_taggable_on :skills

  has_many :invitations, as: :invitable
  has_many :bids
  has_many :projects
  belongs_to :followable, polymorphic: true

  mount_uploader :avatar, AvatarUploader
  store_in_background :avatar

  has_and_belongs_to_many :code_reviews

  scope :search, -> (query) do
    select do |user|
      if user.full_name.include? query or user.username.include? query
        true
      elsif user.company?
        user.company.include? query
      end
    end
  end

  def recent_projects
    Project.recent.select do |project|
      project.user == self
    end
  end

  def popular_projects
    Project.popular.select do |project|
      project.user == self
    end
  end

  def interesting_projects
    Project.interesting.select do |project|
      project.user == self
    end
  end

  def explore
    Project.tagged_with(languages, any: true)
  end

  def join_date
  	created_at.strftime("%B %d, %Y")
  end

  def full_name=(value)
    parts = value.split(' ')
    self.first_name = parts[0]
    self.last_name = parts[1]
  end

  def full_name
  	[first_name, last_name].join(' ')
  end

  def last_created_project_at
    unless projects.empty?
      top_project = projects.sort_by { |p| p.created_at }.first
      return top_project.created_at.strftime(pretty_datetime_format_long)
    end
  end

  def recent_tasks
    bids.where(completed_at: Time.now.midnight..Time.now.midnight - 1.day)
  end

  def pending_tasks
    bids.where(pending: true)
  end

  def pending_code_reviews
    code_reviews.where(pending: true)
  end

  def wallet_amount
    "$" + wallet.to_i.to_s
  end

  def breakdown
    [
      ["Completed", 50.0],
      ["Pending", 35.0],
      ["Declined", 15.0]
    ].as_json
  end

  def self.from_omniauth(auth)
    where("email = ? or provider = ? and uid = ?", auth.info.email, auth.info.provider, auth.info.uid).first_or_create do |user|
      user.password = Devise.friendly_token[0,20] if user.password.nil?

      if auth.info
        user.email = auth.info.email if user.email.nil?
        user.username = auth.info.username if user.username.nil?
        user.github_profile_url = auth.info.urls["GitHub"] unless auth.info.urls.blank?
        unless auth.extra.raw_info.blank?
          user.company = auth.extra.raw_info.company if user.company.nil?
          user.location = auth.extra.raw_info.location if user.location.nil?
          user.hireable = auth.extra.raw_info.hireable 
        end
        user.remote_avatar_url = auth.info.image if user.avatar.nil?
        if user.full_name.nil?
          n = auth.info.name.split(' ', 2)
          user.first_name = n.first
          user.last_name = n.last
        end
      end
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
        user.github_profile_url = data["url"] if user.github_profile_url.blank?
        user.company = data["company"] if user.company.blank?
        user.location = data["location"] if user.location.blank?
        user.hireable = data["hireable"]
        user.remote_avatar_url = data["avatar_url"] if user.avatar.blank?
        n = data["name"].split(' ', 2)
        user.first_name = n.first if user.first_name.blank?
        user.last_name = n.last if user.last_name.blank?
      end
    end
  end

  def invite!(params)
    params[:invitable] = self
    return Invitation.create!(params)
  end

  def authorized?
    senior? || admin?
  end

  def authorization
    if admin
      "Administrator"
    elsif senior
      "Manager"
    else
      "Contractor"
    end
  end

  def ensure_auth_token
    if auth_token.blank?
      self.auth_token = generate_auth_token
    end
  end

  def self.github_auth_url
    "https://github.com/login/oauth/authorize?scope=repo,user:email&client_id=#{ENV['GITHUB_CLIENT_ID']}&secret_key=#{ENV['GITHUB_SECRET']}"
  end

  private

  def generate_auth_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(auth_token: token).first
    end
  end

  def send_welcome_email
    UserMailer.welcome_email(self)
  end

end
