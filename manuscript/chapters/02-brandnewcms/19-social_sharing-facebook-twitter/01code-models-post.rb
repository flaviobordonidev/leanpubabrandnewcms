class Post < ApplicationRecord

  # == Constants ============================================================

  # == Attributes ===========================================================
  
  # getter method --------------------------------------------------------------
  def display_day_published 
    if published_at.present?
      created_at.strftime('%-d %-b %Y')
      #"Published #{created_at.strftime('%-d %-b %Y')}"
    else
      "not published yet"
    end
  end
  #-----------------------------------------------------------------------------
  
  # == Extensions ===========================================================

  # shrine required ------------------------------------------------------------
  include ImageUploader[:image]
  include ImageUploader[:sharing_image]
  #-----------------------------------------------------------------------------

  # friendly_id required -------------------------------------------------------
  extend FriendlyId
  friendly_id :title, use: :slugged
  #-----------------------------------------------------------------------------

  # == Relationships ========================================================

  belongs_to :author

  # == Validations ==========================================================

  validates :title, presence: true
  validates :sharing_description, length: { maximum: 160 }

  # == Scopes ===============================================================

  scope :most_recent, -> { order(published_at: :desc) }
  scope :published, -> { where(published: true) }

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  def should_generate_new_friendly_id?
    title_changed?
  end

  # == Instance Methods =====================================================

end
