class Component < ApplicationRecord

  # == Constants ============================================================

  # == Attributes ===========================================================

  # ==== globalize required
  translates :name, :description, :fallbacks_for_empty_translations => true

  # == Extensions ===========================================================

  # ==== paperclip required
  has_attached_file :image, styles: { thumb: ["64x64!", :png] }

  # == Relationships ========================================================

  # ==== one-to-many
  #belongs_to :company
  #belongs_to :company, foreign_key: :supplier_id
  #belongs_to :company, foreign_key: :factory_id
  belongs_to :supplier, class_name: 'Company'
  belongs_to :factory, class_name: 'Company'

  # == Validations ==========================================================

  # ==== paperclip required
  validates_attachment :image,
                        content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

  # == Scopes ===============================================================

  scope :search, -> (query) {with_translations.where("part_number ILIKE ? OR name ILIKE ?", "%#{query.strip}%", "%#{query.strip}%")}

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
end
