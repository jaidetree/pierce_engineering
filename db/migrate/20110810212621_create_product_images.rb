class CreateProductImages < ActiveRecord::Migration
  def self.up
    create_table :product_images do |t|
      t.string :name
      t.string :caption
      t.text :content
      t.references :product

      t.timestamps
    end
  end

  def self.down
    drop_table :product_images
  end
end
