class CreateNews < ActiveRecord::Migration
  def self.up
    create_table :news do |t|
      t.string :title
      t.text :excerpt
      t.text :content
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :news
  end
end
