class EgPost < ApplicationRecord
  # == Constants ============================================================
  
  # == Extensions ===========================================================

  # == Attributes ===========================================================

  ## Active Storage
  has_one_attached :header_image
  
  ## Action Text
  has_rich_text :content

  # == Relationships ========================================================

  ## association one-to-many
  belongs_to :user

  # == Validations ==========================================================

  # == Scopes ===============================================================

  scope :published, -> { where(published: true) }

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

  ## getter method
  def published_at_formatted 
    if published_at.present?
      ActionController::Base.helpers.l published_at, format: :my_long
    else
      ActionController::Base.helpers.t 'eg_posts.not_published'
    end
  end
end