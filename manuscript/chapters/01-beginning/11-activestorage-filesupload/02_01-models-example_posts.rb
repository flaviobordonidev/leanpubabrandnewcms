class ExamplePost < ApplicationRecord

 has_one_attached :header_image

  belongs_to :user
end
