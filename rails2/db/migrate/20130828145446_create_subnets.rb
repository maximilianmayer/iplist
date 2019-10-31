class CreateSubnets < ActiveRecord::Migration
  def self.up
    drop_table :subnets
    create_table :subnets do |t|
      t.string :name, :ip_class, :ip_start, :ip_end, :gateway, :mask, :dhcp_start, :dhcp_end, :location
      t.timestamps
    end
  end

  def self.down
    drop_table :subnets
  end
end
