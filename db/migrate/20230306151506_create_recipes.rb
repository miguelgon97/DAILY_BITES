class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :rating
      t.text :description
      t.integer :prep_time

      t.timestamps
    end
  end
end
