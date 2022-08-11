class USer < ApplicationRecord
  scope :active, -> { where(active: true) }
end