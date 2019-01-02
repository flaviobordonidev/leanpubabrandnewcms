class ExamplePost < ApplicationRecord
  belongs_to :user
  
  has_one_attached :header_image
end
