class ChangeProductPriceToText < ActiveRecord::Migration
  def self.up
	  change_column :products, :price, :text
	  rename_column :products, :price, :prices
  end

  def self.down
	  change_column :products, :prices, :decimal
	  rename_column :products, :prices, :price
  end
end
