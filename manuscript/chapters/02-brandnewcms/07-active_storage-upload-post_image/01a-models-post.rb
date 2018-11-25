class Post < ApplicationRecord
  # == Constants ============================================================

  # == Attributes ===========================================================

  ## rolify 
  resourcify

  ## ActiveStorage
  has_one_attached :header_image
  has_one_attached :main_image

  # == Extensions ===========================================================

  ## friendly_id 
  extend FriendlyId
  friendly_id :title, use: :slugged

  # == Relationships ========================================================

  ## one-to-many
  belongs_to :user

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================
  
  # == Instance Methods =====================================================

  def should_generate_new_friendly_id?
    title_changed?
  end

end
