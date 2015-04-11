class Invitation < ActiveRecord::Base

  belongs_to :invitable, polymorphic: true

  validates_uniqueness_of :email
  validates :email, email: true

  def self.code
    SecureRandom.uuid
  end

end