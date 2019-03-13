class Post < ApplicationRecord
  # == Constants ============================================================

  # == Attributes ===========================================================

  enum type_of_content: {image: 0, video_youtube: 1, video_vimeo:2, audio:3}
  
  ## ActiveStorage
  has_one_attached :main_image
  
  # == Extensions ===========================================================

  ## friendly_id
  extend FriendlyId
  friendly_id :title, use: :slugged

  # == Relationships ========================================================

  belongs_to :user

  # == Validations ==========================================================

  # == Scopes ===============================================================

  scope :published, -> { where(published: true) }

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
  
  def should_generate_new_friendly_id?
    title_changed?
  end
  
end
