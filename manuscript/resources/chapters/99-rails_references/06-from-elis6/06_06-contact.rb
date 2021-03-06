class Contact < ApplicationRecord

  # == Constants ============================================================

  # == Attributes ===========================================================

  # ==== globalize required
  translates :medium, :fallbacks_for_empty_translations => true

  # ==== virtual attributes
  # setter method
  attr_writer :favorite_cb
  
  # getter method
  def favorite_cb
    #raise "summary: #{summary} - favorite_id: #{favorite_id} - id: #{id}"
    if favorite_id.blank?
      false
    else
      true
    end
  end

  # == Extensions ===========================================================

  # == Relationships ========================================================

  # ==== polymorphic
  belongs_to :contactable, polymorphic: true
  has_many :favorites, as: :favoritable

  # == Validations ==========================================================

  # == Scopes ===============================================================

  scope :search, -> (query) {with_translations.where("medium ILIKE ? OR identifier ILIKE ?", "%#{query.strip}%", "%#{query.strip}%")}

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
end
