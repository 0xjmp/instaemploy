class CodeReview < ActiveRecord::Base

  has_and_belongs_to_many :users

  belongs_to :bid

  validates_presence_of :markdown, :users, :bid

end