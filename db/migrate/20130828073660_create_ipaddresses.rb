class CreateIpaddresses < ActiveRecord::Migration
  def self.up
    drop_table :ipaddresses
    create_table :ipaddresses do |t|
      t.string :hostname, :address, :subnet, :iptype, :comment
      t.timestamps
    end
  end

  def self.down
    drop_table :ipaddresses
  end
end
