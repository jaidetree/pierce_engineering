class AddProductsToNews < ActiveRecord::Migration
  def self.up
    add_column :news, :products, :text
  end

  def self.down
    remove_column :news, :products
  end
end
