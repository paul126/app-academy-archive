class Band < ActiveRecord::Base

  validates :name, presence: true

  has_many(
    :albums,
    class_name: "Album",
    foreign_key: :band_id,
    primary_key: :id,
    dependent: :destroy
  )

  def self.all_bands_alphabetical_with_id
    self.select(:name, :id).order(:name)
  end


end
