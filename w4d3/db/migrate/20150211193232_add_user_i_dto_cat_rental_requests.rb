class AddUserIDtoCatRentalRequests < ActiveRecord::Migration
  def change
    add_column :cat_rental_requests, :user_id, :integer, not_null: false
  end
end
