class Ingredient < ApplicationRecord
  has_many :user_ingredients
  has_many :recipe_ingredients
  has_many :users, through: :user_ingredient
  has_many :recipes, through: :recipe_ingredient

  include PgSearch::Model
  pg_search_scope :search_by_name,
                against: [:name],
                using: {
                  tsearch: { prefix: true }
                }
end
