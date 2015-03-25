class ShortenedUrl < ActiveRecord::Base

  validate :short_url, presence: true, uniqueness: true
  validate :long_url, presence: true, length: { maximum: 500 }
  validate :user_id, presence: true
  validate :long_url_cannot_be_submit_more_than_five_times_in_one_minute

  def self.random_code

    short_url = SecureRandom.urlsafe_base64

    while ShortenedUrl.exists?(:short_url => short_url)
      short_url = SecureRandom.urlsafe_base64
    end

    short_url

  end

  def self.create_for_user_and_long_url!(user, long_url)

    ShortenedUrl.create!(user_id: user.id, long_url: long_url, short_url: random_code)

  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visits.select(:user_id).distinct.where(:created_at => 10.minutes.ago..Time.now).count
  end

  belongs_to(
    :user,
    :class_name => "User",
    :foreign_key => :user_id,
    :primary_key => :id
  )

  has_many(
    :visits,
    :class_name => "Visit",
    :foreign_key => :short_url_id,
    :primary_key => :id
  )

  has_many(
    :visitors,
    Proc.new { distinct },
    :through => :visits,
    :source => :visitor
    )

  has_many(
    :taggings,
    :class_name => "Tagging",
    :foreign_key => :short_url_id,
    :primary_key => :id
  )

  has_many(
    :tags,
    :through => :taggings,
    :source => :tag_topic
  )

  private
  def long_url_cannot_be_submit_more_than_five_times_in_one_minute
    if user.submitted_urls.where(:created_at => 1.minute.ago..Time.now).count >= 5
      errors[:user] << "can't submit that many URLs in one minute"
    end
  end

end
