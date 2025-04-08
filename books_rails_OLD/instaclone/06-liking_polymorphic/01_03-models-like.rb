class Like < ApplicationRecord
  belongs_to :user
  ## polymorphic
  belongs_to :likeable, polymorphic: true
end
