class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  acts_as_favoritor

  has_many :user_ingredients
  has_many :ingredients, through: :user_ingredients
  has_many :reviews

  #validates :user_name, presence: true, uniqueness: true

end
