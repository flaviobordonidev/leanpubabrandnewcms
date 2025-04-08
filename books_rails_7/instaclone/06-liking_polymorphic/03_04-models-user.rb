class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :likes
  has_many :comments

  validates :username, presence: true

  #def like!(post)
    #likes << Like.new(post: post)
  #end

  def like!(item_type, item_id)
    likes << Like.new(likeable_type: item_type, likeable_id: item_id)
  end

end
