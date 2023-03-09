class AddColumnsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :household, :string
    add_column :users, :food_preferences, :string
    add_column :users, :allergies, :string
    add_column :users, :intolerances, :string
  end
end
