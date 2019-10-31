# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130828145446) do

  create_table "ipaddresses", :force => true do |t|
    t.string   "hostname"
    t.string   "address"
    t.string   "subnet"
    t.string   "iptype"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.string   "nameshort"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subnets", :force => true do |t|
    t.string   "name"
    t.string   "ip_class"
    t.string   "ip_start"
    t.string   "ip_end"
    t.string   "gateway"
    t.string   "mask"
    t.string   "dhcp_start"
    t.string   "dhcp_end"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
