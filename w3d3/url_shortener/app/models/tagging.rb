class Tagging < ActiveRecord::Base

  belongs_to(
    :url,
    :class_name => 'ShortenedUrl',
    :foreign_key => :short_url_id,
    :primary_key => :id
  )

  belongs_to(
    :tag_topic,
    :class_name => 'TagTopic',
    :foreign_key => :tag_id,
    :primary_key => :id
  )

  def self.create_tag_association!(short_url, number)
    Tagging.create!(short_url_id: short_url.id, tag_id: number)
  end

end
