class Recipe < ApplicationRecord
  acts_as_favoritable

  has_many :recipe_ingredients
  has_many :favorites

  has_many :ingredients, through: :recipe_ingredients

  include PgSearch::Model
  pg_search_scope :recipe_search,
                  against: [:name, :description],
                  associated_against: {
                    ingredient: [:name]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }

end
