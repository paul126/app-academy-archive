class User < ActiveRecord::Base

  attr_reader :password

  validates :user_name, :password_digest, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many(
    :cats,
    class_name: "Cat",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :rental_requests,
    class_name: "CatRentalReqest",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :sessions,
    class_name: "Session",
    foreign_key: :user_id,
    primary_key: :id
  )

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by_user_name(user_name)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

end
