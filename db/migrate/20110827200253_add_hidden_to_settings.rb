class AddHiddenToSettings < ActiveRecord::Migration
  def self.up
    add_column :settings, :hidden, :bool, :default => false
  end

  def self.down
    remove_column :settings, :hidden
  end
end
