class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  validates :name, presence: true,
                   uniqueness: true,
                   length: { maximum: 50 }

  validates :email, presence: true,
                    uniqueness: true,
                    length: { maximum: 50, message: "must be less thatn 50" },
                    format: { with: URI::MailTo::EMAIL_REGEXP } 

  #validates :password             , length: { minimum: 6 }, :if => :validate_password?
  validates :password_confirmation, presence: true        , :if => :validate_password?

  def password_required?
    false
  end

  def validate_password?
    password.present? || password_confirmation.present?
  end
end



---


class User < ApplicationRecord
  #enum role: [:user, :admin, :moderator, :author]
  enum role: {user: 0, admin: 1, moderator:2, author:3}

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  has_many :eg_posts

  validates :name, presence: true,
                   uniqueness: true,
                   length: { maximum: 50 }

  validates :email, presence: true,
                    uniqueness: true,
                    length: { maximum: 50 },
                    format: { with: URI::MailTo::EMAIL_REGEXP } 

  validates :password, presence: true,
                       length: { in: 6..25 }

end
