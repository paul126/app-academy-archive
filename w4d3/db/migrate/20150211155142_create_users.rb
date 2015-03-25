class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name, not_null: false
      t.string :password_digest, not_null: false
      t.string :session_token, not_null: false
      t.timestamps
    end
  end
end
