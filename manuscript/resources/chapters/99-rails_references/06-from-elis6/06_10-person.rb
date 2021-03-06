class Person < ApplicationRecord
  # == Constants ============================================================

  # == Attributes ===========================================================

  # ==== globalize required
  translates :title, :homonym, :memo, :fallbacks_for_empty_translations => true

  # ==== virtual attributes
  # setter method
  attr_writer :favorite_cb
  
  # getter method
  def favorite_cb
    #raise "summary: #{summary} - favorite_id: #{favorite_id} - id: #{id}"
    if favorite_id.blank?
      false
    else
      true
    end
  end
  
  # == Extensions ===========================================================

  # ==== paperclip required
  has_attached_file :image, styles: { thumb: ["64x64!", :png] }

  # == Relationships ========================================================
  
  # ==== polymorphic
  has_many :addresses, as: :addressable
  has_many :contacts, as: :contactable
  has_many :favorites, as: :favoritable
  has_many :histories, as: :historyable

  # ==== many-to-many
  has_many :company_person_maps
  has_many :companies, :through => :company_person_maps
  accepts_nested_attributes_for :companies

  # == Validations ==========================================================

  # ==== paperclip required
  validates_attachment :image,
                        content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

  # == Scopes ===============================================================

  #scope :search, -> (query) {with_translations(I18n.locale).where("title ILIKE ? OR last_name ILIKE ? OR first_name ILIKE ?", "%#{query.strip}%", "%#{query.strip}%", "%#{query.strip}%")}
  #scope :search, -> (query) {with_translations.where("title ILIKE ? OR last_name ILIKE ? OR first_name ILIKE ?", "%#{query.strip}%", "%#{query.strip}%", "%#{query.strip}%")}
  #scope :search, -> (query) {with_translations.where("CONCAT_WS(' ', first_name, last_name) ILIKE ?", "%#{query.strip}%")}
  scope :search, -> (query) {with_translations.where("first_name || ' ' || last_name ILIKE ?", "%#{query.strip}%")}

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
end
