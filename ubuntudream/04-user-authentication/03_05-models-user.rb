class User < ApplicationRecord
  # == Constants ============================================================
  
  # == Extensions ===========================================================

  ## Include default devise modules. Others available are:
  ## :confirmable, :lockable, :registerable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  # == Attributes ===========================================================

  # == Relationships ========================================================

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
end
