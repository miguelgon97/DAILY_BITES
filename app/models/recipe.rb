class Recipe < ApplicationRecord
  acts_as_favoritable
  attribute :calories, :integer

  has_many :recipe_ingredients
  has_many :favorites
  has_many :reviews
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
