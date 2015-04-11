class Project < ActiveRecord::Base
  include PublicActivity::Model
  include ApplicationHelper

  before_create :senior?
  before_validation :set_slug
  before_create :create_repo
  before_destroy :remove_repo

	validates_presence_of :title, :repo_url, :user, :due_date, :slug

	belongs_to :user
  has_many :bids
  has_many :followers, class_name: 'User',  as: :followable

  acts_as_taggable_on :skills

	mount_uploader :avatar, AvatarUploader

  accepts_nested_attributes_for :user

  scope :recent, -> do
    order(created_at: :desc)
  end

  scope :popular, -> do
    where("views > ?", 5000).order(views: :desc)
  end

  scope :interesting, -> do
    []
  end

  scope :search, -> (query) do
    select do |project|
      project.title.include? query or
      project.description.include? query or
      project.user.full_name.include? query
    end
  end

  scope :by_skill, -> (name) do
    tagged_with(name, any: true)
  end

  def following?(u)
    followers.include? u
  end

  def follow!(u)
    followers << u
    save!
  end

  def unfollow!(u)
    followers.delete(u)
    save!
  end

  def current_state(u)
    bid = bids.where(user: u).first
    unless bid.nil?
      bid.state
    else
      Bid.default_state
    end
  end

  protected

  def senior?
    user.senior?
  end

  def create_repo
    GitWorker::Upload.perform_async(id)
  end

  def remove_repo
    GitWorker::Remove.perform_async(id)
  end

  def set_slug
    self.slug = make_slug(self.title)
  end

end