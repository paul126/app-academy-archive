class Cat < ActiveRecord::Base

  CAT_COLORS = [
    "black",
    "grey",
    "brown",
    "white",
    "orange",
    "tan",
    "striped",
    "spotted"
  ]

  validates :birth_date, :name, :color, :sex, :description, :user_id, presence: true
  validates :color, inclusion: CAT_COLORS

  has_many(
    :rental_requests,
    class_name: "CatRentalRequest",
    foreign_key: :cat_id,
    primary_key: :id
  )

  belongs_to(
    :owner,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  def age
    seconds = Time.now - self.birth_date
    age = seconds / 3600 / 24 / 365
    age.to_i
  end

end
