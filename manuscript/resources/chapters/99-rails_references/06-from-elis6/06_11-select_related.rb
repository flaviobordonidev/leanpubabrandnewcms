class SelectRelated < ApplicationRecord

  # == Constants ============================================================

  # == Attributes ===========================================================

  # ==== globalize required
  translates :name, :fallbacks_for_empty_translations => true

  # ==== virtual attributes
  # getter method (non creo il setter method)
  def ico_name
    "ico_#{metadata.singularize}"
  end
  
  # getter method (non creo il setter method)
  def path_name
    "#{metadata}_path"
  end 
  
  # getter method (non creo il setter method)
  def selected_name
    "#{metadata}"
  end

  # == Extensions ===========================================================

  # == Relationships ========================================================

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # ==== scope filters
  scope :for_companies, -> {where(bln_companies: true)}
  scope :for_components, -> {where(bln_components: true)}
  scope :for_dossiers, -> {where(bln_dossiers: true)}
  scope :for_homepage, -> {where(bln_homepage: true)}
  scope :for_people, -> {where(bln_people: true)}
  scope :search, -> (query) {with_translations(I18n.locale).where("name ILIKE ?", "%#{query.strip}%")}

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
end
