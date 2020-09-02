class Company < ApplicationRecord

  # == Constants ============================================================
  
  # == Extensions ===========================================================

  ## globalize required
  translates :note, :sector, :fallbacks_for_empty_translations => true

  # == Attributes ===========================================================

  ## enum
  enum client_type: {c_none: 0, c_goods: 1, c_services: 2, c_goods_and_services: 3}
  enum supplier_type: {s_none: 0, s_goods: 1, s_services: 2, s_goods_and_services: 3}
  
  # == Relationships ========================================================

  has_many :telephones, dependent: :destroy
  accepts_nested_attributes_for :telephones, allow_destroy: true, reject_if: proc{ |attr| attr['number'].blank? }

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

end
