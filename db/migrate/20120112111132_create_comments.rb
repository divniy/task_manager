class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.references :story

      t.timestamps
    end
    add_index :comments, :story_id
  end
end
