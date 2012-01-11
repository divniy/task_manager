class Story < ActiveRecord::Base
  attr_accessible :title, :content

  belongs_to :user
  default_scope :order => "stories.created_at DESC"
end
