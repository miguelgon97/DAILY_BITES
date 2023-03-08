class Recipe < ApplicationRecord
  acts_as_favoritable

  has_many :recipe_ingredients
  has_many :favorites
end
