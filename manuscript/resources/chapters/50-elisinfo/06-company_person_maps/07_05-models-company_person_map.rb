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
  accepts_nested_attributes_for :person
  #accepts_nested_attributes_for :telephones, allow_destroy: true, reject_if: proc{ |attr| attr['number'].blank? }

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

end
