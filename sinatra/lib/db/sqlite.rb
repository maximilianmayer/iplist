require 'sqlite3'
require_relative '../db'

module IPAM
  class Sqlite
    attr_reader :db
    def initialize(name)
      @db = SQLite3::Database.open("db/#{name}.db")
    end

    def init_db
      sql =  <<-SQL
      drop table if exists ip;
      drop table if exists network;
      drop table if exists location;
      create table ip( id INTEGER PRIMARY KEY, ip varchar(15) UNIQUE NOT NULL, prefix varchar(4), hostname varchar(255), type varchar(20), network_id int, location_id int, FOREIGN KEY(network_id) REFERENCES network(id) );
      create table network( id INTEGER PRIMARY KEY, name varchar(255), address varchar(15), prefix varchar(4) , location_id int, FOREIGN KEY(location_id) REFERENCES location(id));
      create table location ( id INTEGER PRIMARY KEY, name varchar(255) );
      insert into network values(0, 'default','1.0.0.0','/8',0);
      insert into location values(0,'default');
      SQL
      @db.execute_batch(sql)
    end

    def get_all_ips(net=0)
      @db.query("select ip from ip where network_id = #{net}")
    end

    def write

    end

    def read

    end
  end
end
