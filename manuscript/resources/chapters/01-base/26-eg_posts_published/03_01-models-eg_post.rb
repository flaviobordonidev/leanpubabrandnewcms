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
      #published_at.strftime('%-d %-B %Y')
      #"Pubblicato il #{published_at.strftime('%-d %-b %Y')}"
      ActionController::Base.helpers.l published_at, format: :long
    else
      "non pubblicato"
    end
  end
  
end
