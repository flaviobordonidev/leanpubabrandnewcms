class Company < ApplicationRecord

  # == Constants ============================================================
  
  # == Extensions ===========================================================

  ## globalize required
  translates :note, :sector, :fallbacks_for_empty_translations => true

  # == Attributes ===========================================================

  ## enum
  enum client_type: {none: 0, goods: 1, services: 2, goods_and_services: 3}
  enum supplier_type: {none: 0, goods: 1, services: 2, goods_and_services: 3}
  
  # == Relationships ========================================================

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

end
