class User < ActiveRecord::Base
  attr_accessible :name, :email

  has_many  :stories, :dependent => :destroy

  validates :name,    :presence => true,
                      :length => { :minimum => 5, :maximum => 50 }

  validates :email,   :presence => true,
                      :uniqueness => true,
                      :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, :on => :create }
end
