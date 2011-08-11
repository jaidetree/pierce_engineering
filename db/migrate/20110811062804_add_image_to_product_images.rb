class AddImageToProductImages < ActiveRecord::Migration
  def self.up
    add_column :product_images, :image, :text
  end

  def self.down
    remove_column :product_images, :image
  end
end
