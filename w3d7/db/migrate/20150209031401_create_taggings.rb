class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.references :rag, index: true
      t.references :article, index: true

      t.timestamps
    end
  end
end
