class Person < ApplicationRecord

  # == Constants ============================================================
  
  # == Extensions ===========================================================

  ## globalize required
  translates :title, :fallbacks_for_empty_translations => true
  
  # == Attributes ===========================================================

  # == Relationships ========================================================

  ## nested-forms + polymorphic
  has_many :telephones, dependent: :destroy, as: :telephoneable
  accepts_nested_attributes_for :telephones, allow_destroy: true, reject_if: proc{ |attr| attr['number'].blank? }

  ## nested-form + polymorphic
  has_many :emails, dependent: :destroy, as: :emailable
  accepts_nested_attributes_for :emails, allow_destroy: true, reject_if: proc{ |attr| attr['address'].blank? }

  ## many-to-many
  has_many :company_person_maps
  has_many :companies, :through => :company_person_maps
  accepts_nested_attributes_for :companies

  # == Validations ==========================================================

  # == Scopes ===============================================================

  #scope :search, -> (query) {with_translations(I18n.locale).where("title ILIKE ? OR last_name ILIKE ? OR first_name ILIKE ?", "%#{query.strip}%", "%#{query.strip}%", "%#{query.strip}%")}
  #scope :search, -> (query) {with_translations.where("title ILIKE ? OR last_name ILIKE ? OR first_name ILIKE ?", "%#{query.strip}%", "%#{query.strip}%", "%#{query.strip}%")}
  #scope :search, -> (query) {with_translations.where("CONCAT_WS(' ', first_name, last_name) ILIKE ?", "%#{query.strip}%")}
  scope :search, -> (query) {with_translations.where("title || ' ' || first_name || ' ' || last_name ILIKE ?", "%#{query.strip}%")}

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

end
