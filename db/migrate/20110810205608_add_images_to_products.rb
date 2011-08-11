class AddImagesToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :images, :text
  end

  def self.down
    remove_column :products, :images
  end
end
