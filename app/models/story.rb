class Story < ActiveRecord::Base
  #attr_reader :state_id
  attr_accessible :title, :content, :user_id, :state_id

  belongs_to :user
  has_many :comments, :dependent => :destroy

  default_scope :order => "stories.created_at DESC"

  composed_of :state,
      :mapping => [ %W(state id) ],
      :constructor => Proc.new { |state| State.new(state || 1) }

#:allow_nil => true,
  # Я немного вспотел, пока заставил работать предыдущую конструкцию,
  # поэтому пришлось добавить следующие два метода для упрощения работы с селектами в формах

  def state_id
    self.state.id
  end

  def state_id=(value)
    self.state = State.new(value)
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