class Track < ActiveRecord::Base

  validates :title, :album_id, presence: true
  validates :track_type, presence: true, inclusion: ["REGULAR", "BONUS"]

  belongs_to(
    :album,
    class_name: "Album",
    foreign_key: :album_id,
    primary_key: :id
  )

  has_many(
    :notes,
    class_name: "Note",
    foreign_key: :track_id,
    primary_key: :id
  )

end
