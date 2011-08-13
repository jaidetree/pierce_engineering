class RemoveImagesFromProducts < ActiveRecord::Migration
  def self.up
    remove_column :products, :images
  end

  def self.down
    add_column :products, :images, :text
  end
end
