class Address < ApplicationRecord

  # == Constants ============================================================

  # == Attributes ===========================================================

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
  belongs_to :addressable, polymorphic: true
  has_many :favorites, as: :favoritable

  # == Validations ==========================================================

  # == Scopes ===============================================================

  scope :search, -> (query) {where("full_address ILIKE ? OR address_tag ILIKE ?", "%#{query.strip}%", "%#{query.strip}%")}

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
end
