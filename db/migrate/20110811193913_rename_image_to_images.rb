class RenameImageToImages < ActiveRecord::Migration
  def self.up
	  rename_column :product_images, :image, :images
  end

  def self.down
	  rename_column :product_images, :images, :image
  end
end
