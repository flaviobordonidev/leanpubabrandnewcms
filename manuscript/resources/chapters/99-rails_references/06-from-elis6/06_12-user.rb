class User < ApplicationRecord

  # == Constants ============================================================

  # == Attributes ===========================================================

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  # == Extensions ===========================================================

  # == Relationships ========================================================

  # ==== polymorphic
  has_many :favorites, as: :favoritable

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

end
