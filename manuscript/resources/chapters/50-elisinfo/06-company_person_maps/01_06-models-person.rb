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

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

end
