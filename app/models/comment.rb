class Comment < ActiveRecord::Base
  attr_accessible :content

  belongs_to :story

  default_scope :order => 'comments.created_at ASC'

  validates_presence_of :content
end
