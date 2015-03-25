class Album < ActiveRecord::Base

  validates :title, :band_id, presence: true
  validates :album_type, presence: true, inclusion: ["STUDIO", "LIVE"]

  has_many(
    :tracks,
    class_name: "Track",
    foreign_key: :album_id,
    primary_key: :id,
    dependent: :destroy
  )

  belongs_to(
    :band,
    class_name: "Band",
    foreign_key: :band_id,
    primary_key: :id
  )

  def self.all_albums_alphabetical_with_id
    self.select(:title, :id).order(:title)
  end


end
