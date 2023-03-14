class AddNameToSupermarkets < ActiveRecord::Migration[7.0]
  def change
    add_column :supermarkets, :name, :string
  end
end
