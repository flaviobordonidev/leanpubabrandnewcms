class Company < ApplicationRecord

  # == Constants ============================================================

  # == Attributes ===========================================================
  
  # ==== paperclip
  attr_accessor :remove_logo

  # ==== globalize required
  translates :sector, :memo, :fallbacks_for_empty_translations => true

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
  has_attached_file :logo, styles: { thumb: ["64x64!", :png] }

  # == Relationships ========================================================
  
  # ==== polymorphic
  has_many :addresses, as: :addressable
  has_many :contacts, as: :contactable
  has_many :favorites, as: :favoritable
  has_many :histories, as: :historyable

  # ==== many-to-many
  has_many :company_person_maps
  has_many :people, :through => :company_person_maps
  accepts_nested_attributes_for :people

  # ==== one-to-many
  #has_many :components
  has_many :components, foreign_key: :supplier_id
  has_many :components, foreign_key: :factory_id

  # == Validations ==========================================================
  
  # ==== paperclip required
  validates_attachment :logo,
                        content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

  # == Scopes ===============================================================

  scope :search, -> (query) {with_translations.where("name ILIKE ?", "%#{query.strip}%")}
  
  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
end
