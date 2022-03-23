class MyModel < ApplicationRecord
  # == Constants ============================================================
  
  GENDERS = [[‘Male’, ‘m’], [‘Female’, ’f’]].freeze

  # == Extensions ===========================================================

  ## friendly_id
  extend FriendlyId

  # == Attributes ===========================================================
  
  ## friendly_id
  friendly_id :title, use: :slugged

  ## globalize
  translates :sector, :memo, :fallbacks_for_empty_translations => true

  ## paperclip
  attr_accessor :remove_logo
  has_attached_file :logo, styles: { thumb: ["64x64!", :png] }
  has_attached_file :avatar, styles: {
    square_100: ‘100x100#’,
    square_300: ‘300x300#’
  }
  
  # == Relationships ========================================================
  
  ## association one-to-many
  has_many :documents

  # == Validations ==========================================================
  
  validates: email, presence:     true,
                    uniqueness:   true,
                    email_format: true

  # == Scopes ===============================================================

  scope :published, -> { where(published: true) }
  scope :search, -> (query) {where("full_address ILIKE ? OR address_tag ILIKE ?", "%#{query.strip}%", "%#{query.strip}%")}
  scope :tagged, -> (tag){ tagged_with(tag) }

  # == Callbacks ============================================================
  
  before_validation :normalize_name, on: :create
  after_validation :set_location, on: [ :create, :update ]
    
  # == Class Methods ========================================================
  
  def self.for_select
    all.collect{|u| [“#{u.name} (#{u.email})”, u.id]}
  end

  def self.from_the_class
    "Hello, from a class method"
  end

  # == Instance Methods =====================================================

  def from_an_instance
    "Hello, from an instance method"
  end
 
  private
    def normalize_name
      self.name = name.downcase.titleize
    end
 
    def set_location
      self.location = LocationService.query(self)
    end

end
