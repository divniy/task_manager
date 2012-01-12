class RenameNameInUser < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.rename :name, :full_name
    end
  end

  def down
    change_table :users do |t|
      t.rename :full_name, :name
    end
  end
end
