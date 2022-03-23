class EgPost < ApplicationRecord
  has_one_attached :header_image
  has_rich_text :content

  belongs_to :user
end
