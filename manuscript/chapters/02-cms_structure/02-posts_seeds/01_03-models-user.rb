class User < ApplicationRecord
  # == Constants ============================================================
  
  # == Extensions ===========================================================

  # == Attributes ===========================================================

  enum role: {user: 0, admin: 1, moderator:2, author:3}

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :registerable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  # == Relationships ========================================================

  has_many :eg_posts
  has_many :posts

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

end
