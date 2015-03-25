class ContactGroup < ActiveRecord::Base

  validates :name, :user_id, presence: true

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :group_memberships,
    class_name: "GroupMembership",
    foreign_key: :contact_group_id,
    primary_key: :id
  )

  has_many(
    :contacts,
    through: :group_memberships,
    source: :contact
  )
end
