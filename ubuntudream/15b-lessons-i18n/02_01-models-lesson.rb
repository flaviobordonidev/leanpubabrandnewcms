class Lesson < ApplicationRecord
  # == Constants ============================================================
  
  # == Extensions ===========================================================

  ## i18n dynamic
  extend Mobility
  translates :name, type: :string
  #translates :description, type: :text
  
  # == Attributes ===========================================================

  ## ActiveText
  has_rich_text :description_rtf

  ## ActiveStorage
  has_one_attached :picture_image
  has_one_attached :picture_author_image

  # == Relationships ========================================================

  ## one-to-many
  has_many :steps, dependent: :destroy

  # == Validations ==========================================================

  # == Scopes ===============================================================

  scope :search, -> (query) {where("name ILIKE ?", "%#{query.strip}%")}

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
end
