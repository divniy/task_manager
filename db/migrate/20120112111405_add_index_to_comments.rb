class AddIndexToComments < ActiveRecord::Migration
  def change
    remove_index :comments, :story_id
    add_index :comments, [:story_id, :created_at], :unique => true
  end
end
