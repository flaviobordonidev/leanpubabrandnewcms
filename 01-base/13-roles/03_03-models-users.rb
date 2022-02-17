class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  #enum language: [:it, :en]
  enum language: {it: 0, en: 1}
  #enum role: [:user, :admin, :moderator, :author]
  enum role: {user: 0, admin: 1, moderator:2, author:3}
  
  has_many :eg_posts
end
