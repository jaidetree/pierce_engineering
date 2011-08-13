class AddTypeToProductCategories < ActiveRecord::Migration
  def self.up
    add_column :product_categories, :cat_type, :int, :limit => 3, :default => 0, :null => false
	  ProductCategory.update_all [ "cat_type = ?", 0 ]
  end

  def self.down
    remove_column :product_categories, :cat_type
  end
end
