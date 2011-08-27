class AddDataToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :data, :text
  end

  def self.down
    remove_column :pages, :data
  end
end
