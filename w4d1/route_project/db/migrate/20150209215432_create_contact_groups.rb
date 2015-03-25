class CreateContactGroups < ActiveRecord::Migration
  def change
    create_table :contact_groups do |t|
      t.string :name, null: false
      t.integer :user_id, null: false
      t.timestamps

    end

    create_table :group_memberships do |t|
      t.integer :contact_group_id, null: false
      t.integer :contact_id, null: false
      t.timestamps
    end

    add_index :group_memberships, [:contact_group_id, :contact_id], unique: true

  end
end
