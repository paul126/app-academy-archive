require 'byebug'

class CatRentalRequest < ActiveRecord::Base

  STATUSES = [
    "APPROVED",
    "PENDING",
    "DENIED"
  ]

  validates :cat_id, :start_date, :end_date, :status, :user_id, presence: true
  validates :status, inclusion: STATUSES
  validate :overlapping_approved_requests

  belongs_to(
    :cat,
    class_name: "Cat",
    foreign_key: :cat_id,
    primary_key: :id,
    dependent: :destroy
  )

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :user
  )



  def pending?
    self.status == "PENDING"
  end

  def approve!

    self.status = "APPROVED"

    self.transaction do
      overlapping_requests.each { |olr| olr.deny! }
      self.save
    end
#    redirect_to root

  end

  def deny!
    self.status = "DENIED"
    self.save
#    redirect_to("/cats")
  end

  def pending?
    self.status == "PENDING"
  end

  private

  def overlapping_requests
    scrr = CatRentalRequest.all.where(cat_id: self.cat_id)
    olr = []

    scrr.each do |rental_request|
      start = rental_request.start_date
      endd = rental_request.end_date

      if self.start_date.between?(start, endd)
        olr << rental_request
      elsif self.end_date.between?(start, endd)
        olr << rental_request
      end
    end

    olr
  end

  def overlapping_approved_requests

    olar = []

    overlapping_requests.each do |olr|
      olar << olr if olr.status == "APPROVED"
    end

    olar.empty?

  end



end
