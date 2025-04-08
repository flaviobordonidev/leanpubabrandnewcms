class Company < ApplicationRecord

  # == Constants ============================================================
  
  # == Extensions ===========================================================

  ## globalize required
  translates :note, :sector, :fallbacks_for_empty_translations => true

  # == Attributes ===========================================================

  ## enum
  enum client_type: {c_none: 0, c_goods: 1, c_services: 2, c_goods_and_services: 3}
  enum supplier_type: {s_none: 0, s_goods: 1, s_services: 2, s_goods_and_services: 3}

  ## Active Storage
  has_one_attached :logo_image
    
  # == Relationships ========================================================

  ## nested-forms + polymorphic
  has_many :telephones, dependent: :destroy, as: :telephoneable
  accepts_nested_attributes_for :telephones, allow_destroy: true, reject_if: proc{ |attr| attr['number'].blank? }

  has_many :emails, dependent: :destroy, as: :emailable
  accepts_nested_attributes_for :emails, allow_destroy: true, reject_if: proc{ |attr| attr['address'].blank? }

  has_many :socials, dependent: :destroy, as: :socialable
  accepts_nested_attributes_for :socials, allow_destroy: true, reject_if: proc{ |attr| attr['address'].blank? }

  ## many-to-many
  has_many :company_person_maps
  has_many :people, :through => :company_person_maps
  accepts_nested_attributes_for :people
  
  # == Validations ==========================================================

  # == Scopes ===============================================================

  #scope :search, -> (query) {with_translations(I18n.locale).where("name ILIKE ?", "%#{query.strip}%")}
  #scope :search, -> (query) {with_translations.where("name ILIKE ?", "%#{query.strip}%")}
  scope :search, -> (query) {with_translations(I18n.locale).distinct.where("name ILIKE ?", "%#{query.strip}%")}

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

end
