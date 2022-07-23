class CompanyPersonMap < ApplicationRecord

  # == Constants ============================================================

  # == Attributes ===========================================================

  # ==== globalize required
  translates :summary, :building, :job_title, :fallbacks_for_empty_translations => true

  # ==== virtual attributes
  # setter methods
  attr_writer :favorite_cb_company, :favorite_cb_person
  
  # getter method
  def favorite_cb_company
    #raise "summary: #{summary} - favorite_id_company: #{favorite_id_company} - id: #{id}"
    if favorite_id_company.blank?
      false
    else
      true
    end
  end

  # getter method
  def favorite_cb_person
    if favorite_id_person.blank?
      false
    else
      true
    end
  end

  # == Extensions ===========================================================

  # == Relationships ========================================================

  # ==== many-to-many
  belongs_to :company
  belongs_to :person

  # == Validations ==========================================================

  validates :company_id,        :presence   => true
  validates :person_id,         :presence   => true

  # == Scopes ===============================================================
  
  # sfrutto lo scope: search del model person 
  scope :search_people, -> (query) {joins(:person).merge(Person.search(query))}
  # sfrutto lo scope: search del model Company 
  scope :search_companies, -> (query) {joins(:company).merge(Company.search(query))}

  # == Callbacks ============================================================

  # == Class Methods ========================================================
  
  # == Instance Methods =====================================================
end
