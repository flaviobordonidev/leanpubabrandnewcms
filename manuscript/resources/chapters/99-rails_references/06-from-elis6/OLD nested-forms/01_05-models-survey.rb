class Survey < ApplicationRecord
  has_many :questions, inverse_of: :survey, dependent: :destroy
  accepts_nested_attributes_for :questions, reject_if: lambda { |a| a[:content].blank? }, allow_destroy: true
end
