class CompanyPersonMap < ApplicationRecord
  # == Constants ============================================================
  
  # == Extensions ===========================================================

  ## globalize required
  translates :summary, :fallbacks_for_empty_translations => true
  
  # == Attributes ===========================================================

  # == Relationships ========================================================

  ## many-to-many
  belongs_to :company
  belongs_to :person
  accepts_nested_attributes_for :person #questo permette persone annidate e a cascata anche le loro tabelle polimorfiche (telphonable, emailable,...)

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

end
