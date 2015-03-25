class AddUserIdToCats < ActiveRecord::Migration
  def change
    add_column :cats, :user_id, :integer, not_null: false

    add_index :cats, :user_id
  end
end
