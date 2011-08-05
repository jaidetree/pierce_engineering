class CreateProductCategories < ActiveRecord::Migration
  def self.up
    create_table :product_categories do |t|
      t.references :product
      t.string :name
      t.string :slug
      t.text :content
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :product_categories
  end
end
