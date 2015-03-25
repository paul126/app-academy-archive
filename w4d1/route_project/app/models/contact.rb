class Contact < ActiveRecord::Base
  validates :email, presence: true, uniqueness: {scope: :user_id}
  validates :name, presence: true
  validates :user_id, presence: true

  belongs_to(
    :owner,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :contact_shares,
    class_name: "ContactShare",
    foreign_key: :contact_id,
    primary_key: :id

  )

  has_many(
    :shared_users,
    through: :contact_shares,
    source: :user
  )

  has_many :comments, as: :commentable

  has_many(
    :group_memberships,
    class_name: "GroupMembership",
    foreign_key: :contact_id,
    primary_key: :id
  )

  has_many(
    :groups,
    through: :group_memberships,
    source: :group
  )

end
