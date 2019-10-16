class Post < ApplicationRecord
  # == Constants ============================================================
  
  # == Extensions ===========================================================

  ## friendly_id
  extend FriendlyId
  
  # == Attributes ===========================================================

  enum content_type: {image: 0, video_youtube: 1, video_vimeo: 2, audio: 3}

  ## ActiveStorage
  has_one_attached :main_image
  has_one_attached :paragraph_image1
  has_one_attached :paragraph_image4
  has_one_attached :paragraph_image5
  has_one_attached :paragraph_image6

  ## friendly_id
  friendly_id :title, use: :slugged

  ## acts_as_taggable_on
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  
  # == Relationships ========================================================

  ## one-to-many
  belongs_to :user

  has_many :post_paragraphs, inverse_of: :post, dependent: :destroy
  accepts_nested_attributes_for :post_paragraphs
  
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

  ## getter method
  def published_at_formatted 
    if published_at.present?
      published_at.strftime('%-d %-b %Y')
      #"Published #{published_at.strftime('%-d %-b %Y')}"
    else
      "not published yet"
    end
  end

end
