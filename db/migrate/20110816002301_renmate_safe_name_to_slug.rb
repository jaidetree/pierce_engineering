class RenmateSafeNameToSlug < ActiveRecord::Migration
  def self.up
	  rename_column :product_categories, :safe_name, :slug
  end

  def self.down
	  rename_column :product_categories, :slug, :safe_name
  end
end
