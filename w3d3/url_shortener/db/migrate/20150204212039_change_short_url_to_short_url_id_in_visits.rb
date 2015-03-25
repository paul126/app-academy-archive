class ChangeShortUrlToShortUrlIdInVisits < ActiveRecord::Migration
  def change
    remove_column :visits, :short_url
    add_column :visits, :short_url_id, :integer

  end
end
