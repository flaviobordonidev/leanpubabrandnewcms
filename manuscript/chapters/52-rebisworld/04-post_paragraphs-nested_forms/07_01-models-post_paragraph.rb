class PostParagraph < ApplicationRecord
  # == Constants ============================================================
  
  # == Extensions ===========================================================

  # == Attributes ===========================================================

  enum pstyle: {central: 0, left: 1, right:2}

  ## ActiveStorage
  has_one_attached :image

  # == Relationships ========================================================

  #belongs_to :post
  belongs_to :post, inverse_of: :post_paragraphs
  default_scope { order(list_position: "ASC") }
  
  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

end
