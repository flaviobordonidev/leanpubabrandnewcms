class Post < ApplicationRecord
  # == Constants ============================================================
  
  # == Extensions ===========================================================

  ## friendly_id
  extend FriendlyId
  
  # == Attributes ===========================================================

  ## friendly_id
  friendly_id :title, use: :slugged

  # == Relationships ========================================================

  ## one-to-many
  belongs_to :user

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

  ## friendly_id
  def should_generate_new_friendly_id?
    title_changed?
  end

end
