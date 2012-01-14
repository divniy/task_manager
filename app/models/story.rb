class Story < ActiveRecord::Base
  attr_accessible :title, :content, :user_id, :state_id

  belongs_to :user
  has_many :comments, :dependent => :destroy

  default_scope :order => "stories.created_at ASC"

  composed_of :state,
      :mapping => [ %W(state id) ],
      :constructor => Proc.new { |state| State.new(state || 1) }

  validates_presence_of :title, :content


  def state_id
    self.state.id
  end

  def state_id=(value)
    self.state = State.new(value)
  end

  def self.states
    State.all
  end

end

class State
  attr_reader :id, :name

  STATE_TABLE = { 1 => :new, 2 => :accepted, 3 => :rejected, 4 => :started, 5 => :finished }.freeze

  def initialize(id = 1)
    @id, @name = id, STATE_TABLE[id]
  end

  def self.all
    STATE_TABLE.collect {|id,name| State.new(id) }
  end

end