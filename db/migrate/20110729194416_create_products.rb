class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.text :excerpt
      t.text :content
      t.decimal :price
      t.text :data
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
