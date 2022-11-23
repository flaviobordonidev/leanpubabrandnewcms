class User < ApplicationRecord
  # == Constants ============================================================
  
  # == Extensions ===========================================================

  ## devise
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  # == Attributes ===========================================================

  ## enum
  #enum role: [:user, :admin, :moderator, :author]
  enum role: {user: 0, admin: 1, moderator:2, author:3}

  ## ActiveStorage
  has_one_attached :avatar_image

  # == Relationships ========================================================

  ## association one-to-many
  has_many :eg_posts
  has_many :answers

  # == Validations ==========================================================

  ## Validation
  validates :username, presence: true

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
end
