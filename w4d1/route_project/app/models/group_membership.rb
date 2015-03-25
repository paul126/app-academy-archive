class GroupMembership < ActiveRecord::Base

  validates :contact_group_id, :contact_id, presence: true
  validates :contact_group_id, uniqueness: { scope: :contact_id }

  belongs_to(
    :contact_group,
    class_name: "ContactGroup",
    foreign_key: :contact_group_id,
    primary_key: :id
  )

  belongs_to(
    :contact,
    class_name: "Contact",
    foreign_key: :contact_id,
    primary_key: :id
  )

end
