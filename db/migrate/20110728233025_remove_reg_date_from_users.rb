class RemoveRegDateFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :reg_date
  end

  def self.down
    add_column :users, :reg_date, :string
  end
end
