class Bid < ActiveRecord::Base

  validates_presence_of :user, :project, :state

  belongs_to :project
  belongs_to :user

  scope :default_state, -> do
    "incomplete"
  end

  def next_state!
    case self.state
      when 'incomplete'
        self.state = 'started'
      when 'started'
        self.state = 'completed'
    end
    save!
  end

  def cancel_state!
    self.state = 'incomplete'
    save!
  end

end