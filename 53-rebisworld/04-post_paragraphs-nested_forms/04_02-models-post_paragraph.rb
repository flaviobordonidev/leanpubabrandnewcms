class PostParagraph < ApplicationRecord
  # == Constants ============================================================
  
  # == Extensions ===========================================================

  # == Attributes ===========================================================

  enum pstyle: {central: 0, left: 1, right:2}

  # == Relationships ========================================================

  #belongs_to :post
  belongs_to :post, inverse_of: :post_paragraphs
  
  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

end