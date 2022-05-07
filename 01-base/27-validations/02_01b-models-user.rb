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
  has_one_attached :account_image
  
  # == Relationships ========================================================

  ## many-to-one
  has_many :eg_posts
  has_many :answers

  # == Validations ==========================================================

  validates :name, presence: true,
                  uniqueness: true,
                  length: { maximum: 50 }

  validates :email, presence: true,
                    uniqueness: true,
                    length: { maximum: 50 },
                    format: { with: URI::MailTo::EMAIL_REGEXP } 

  validates :password, presence: true,
                      length: { in: 6..25 }

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

  def name_shown
    return self.name.blank? ? self.email.split('@')[0].capitalize : self.name
  end
end
