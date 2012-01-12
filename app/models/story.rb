class Story < ActiveRecord::Base
  attr_accessor :state_name
  attr_accessible :title, :content, :user_id, :state, :state_name

  belongs_to :user
  default_scope :order => "stories.created_at DESC"

  STATE_TABLE = { new: 1, accepted: 2, stared: 3, finished: 4, rejected: nil }

  def state_name
    @state_name = STATE_TABLE.key(state)
  end

  def state_name=(value)
    @state, @state_name = STATE_TABLE[value], value
  end

end
