class CreateLocations < ActiveRecord::Migration
  def self.up
    drop_table :locations
    create_table :locations do |t|
      t.string :name, :nameshort
      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
