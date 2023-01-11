class Step < ApplicationRecord
  # == Constants ============================================================
  
  # == Extensions ===========================================================

  ## i18n dynamic
  extend Mobility
  translates :question, type: :string
  translates :cheneso, type: :string
  #translates :youtube_video_id, type: :string
  
  # == Attributes ===========================================================

  # == Relationships ========================================================

  ## many-to-one
  belongs_to :lesson

  ## one-to-many
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: proc{ |attr| attr['content'].blank? }

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
  def next
    lesson.steps.where("id > ?", id).first
  end

  def prev
    lesson.steps.where("id < ?", id).last
  end
end
