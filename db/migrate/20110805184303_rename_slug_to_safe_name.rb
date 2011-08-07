class RenameSlugToSafeName < ActiveRecord::Migration
  def self.up
	  rename_column :product_categories, :slug, :safe_name
  end

  def self.down
	  rename_column :product_categories, :safe_name, :slug
  end
end
