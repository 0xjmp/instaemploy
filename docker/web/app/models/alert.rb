class Alert < ActiveRecord::Base

  validates_presence_of :email, :skill_list

  acts_as_taggable_on :skills

  scope :find_new_skills, -> do
    AlertWorker.perform_async
  end

  def notify!
    AlertMailer.skill_found(self)
    destroy!
  end

end