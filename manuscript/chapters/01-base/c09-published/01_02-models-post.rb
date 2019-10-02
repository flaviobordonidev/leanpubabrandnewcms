class Post < ApplicationRecord
  # == Constants ============================================================
  
  # == Extensions ===========================================================

  ## friendly_id
  extend FriendlyId
  
  # == Attributes ===========================================================

  enum content_type: {image: 0, video_youtube: 1, video_vimeo: 2, audio: 3}

  ## ActiveStorage
  has_one_attached :main_image

  ## friendly_id
  friendly_id :title, use: :slugged

  # == Relationships ========================================================

  ## one-to-many
  belongs_to :user

  # == Validations ==========================================================

  # == Scopes ===============================================================

  scope :published, -> { where(published: true) }

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

  ## friendly_id
  def should_generate_new_friendly_id?
    title_changed?
  end

end
