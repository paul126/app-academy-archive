class ChangeUserParams < ActiveRecord::Migration
  def change
    rename_column :users, :name, :username
    change_column_null :users, :username, false
    remove_column :users, :email, :string

  end
end
