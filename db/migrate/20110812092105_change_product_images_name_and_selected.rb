class ChangeProductImagesNameAndSelected < ActiveRecord::Migration
  def self.up
	  rename_column :product_images, :caption, :image_caption 
	  rename_column :product_images, :name, :image_selected
	  change_column :product_images, :image_selected, :boolean, { :default => false, :null => false }
	  ProductImage.update_all [ "image_selected = ?", false ]
  end

  def self.down
	  rename_column :product_images, :image_caption, :caption 
	  rename_column :product_images, :image_selected, :name
	  change_column :product_images, :name, :string, { :null => true }
	  change_column_default :product_images, :name, nil 
  end
end
