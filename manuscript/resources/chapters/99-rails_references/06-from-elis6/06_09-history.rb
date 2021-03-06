class History < ApplicationRecord

  # == Constants ============================================================

  # == Attributes ===========================================================

  # ==== paperclip
  attr_accessor :remove_attachment
  
  # == Extensions ===========================================================

  # ==== paperclip required
  has_attached_file :attachment, styles: { thumb: ["128x128!", :png] }
  
  # == Relationships ========================================================

  # ==== polymorphic
  belongs_to :historyable, polymorphic: true

  # == Validations ==========================================================

  # ==== paperclip required
  validates_attachment :attachment,
                        content_type: { content_type: ["image/jpeg", "image/gif", "image/png", "application/pdf"] }
                        
  # == Scopes ===============================================================

  scope :search, -> (query) {where("title ILIKE ?", "%#{query.strip}%")}

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
end
