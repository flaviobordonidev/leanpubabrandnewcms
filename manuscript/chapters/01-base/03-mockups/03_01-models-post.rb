class Post < ApplicationRecord
  # == Constants ============================================================

  # == Attributes ===========================================================

  ## rolify 
  resourcify

  ## ActiveStorage
  has_one_attached :header_image
  has_one_attached :main_image

  ## getter method
  def display_day_published 
    if published_at.present?
      created_at.strftime('%-d %-b %Y')
      #"Pupplicato il #{created_at.strftime('%-d %-b %Y')}"
    else
      "not published yet"
    end
  end

  # == Extensions ===========================================================

  ## friendly_id 
  extend FriendlyId
  friendly_id :title, use: :slugged

  # == Relationships ========================================================

  ## one-to-many
  belongs_to :user

  # == Validations ==========================================================

  # == Scopes ===============================================================

  scope :published, -> { where(published: true) }
  scope :most_recent, -> { order(published_at: :desc) }
  scope :order_by_id, -> { order(id: :desc) }

  # == Callbacks ============================================================

  # == Class Methods ========================================================
  
  # == Instance Methods =====================================================

  def should_generate_new_friendly_id?
    title_changed?
  end

end
