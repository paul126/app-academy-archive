class Tagging < ActiveRecord::Base
  belongs_to :rag
  belongs_to :article
end
