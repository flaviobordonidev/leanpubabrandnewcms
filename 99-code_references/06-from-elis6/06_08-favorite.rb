class Favorite < ApplicationRecord

  # == Constants ============================================================

  # == Attributes ===========================================================
  
  # ==== globalize required
  translates :copy_normal, :copy_bold, :fallbacks_for_empty_translations => true

  # == Extensions ===========================================================

  # == Relationships ========================================================
  
  # ==== polymorphic
  belongs_to :favoritable, polymorphic: true

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
  
end
