class Recipe < ApplicationRecord
  acts_as_favoritable
  attribute :calories, :integer

  has_many :recipe_ingredients
  has_many :favorites
end
