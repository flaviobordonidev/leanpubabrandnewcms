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
