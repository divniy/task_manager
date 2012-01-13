class Story < ActiveRecord::Base
  #attr_reader :state_id
  attr_accessible :title, :content, :user_id, :state_id

  belongs_to :user
  has_many :comments, :dependent => :destroy

  default_scope :order => "stories.created_at DESC"

  composed_of :state,
      :mapping => [ %W(state id) ],
      :allow_nil => true,
      :constructor => Proc.new { |state| State.new(state) }

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

  def initialize(id)
    @id, @name = id, STATE_TABLE[id]
  end

  def State.all
    STATE_TABLE.collect {|id,name| State.new(id) }
  end
end