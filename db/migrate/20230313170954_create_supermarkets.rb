class CreateSupermarkets < ActiveRecord::Migration[7.0]
  def change
    create_table :supermarkets do |t|
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
