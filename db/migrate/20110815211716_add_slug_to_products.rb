class AddSlugToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :slug, :string
  end

  def self.down
    remove_column :products, :slug
  end
end
