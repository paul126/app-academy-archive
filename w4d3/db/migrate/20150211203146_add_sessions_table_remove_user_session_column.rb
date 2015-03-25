class AddSessionsTableRemoveUserSessionColumn < ActiveRecord::Migration
  def change

    remove_column :users, :session_token

    create_table :sessions do |t|
      t.integer :user_id, null: false
      t.string :session_token, null: false
      t.timestamps
    end

  end
end
