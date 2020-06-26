require_relative './db'

a = IPlist::DB.new 'bla'

hsh = {12 => {"abc" => "asasas"}}
hsh = {13 => {"aaabc" => "asasas"}}

a.write hsh
puts a.get_ids
puts a.get_all
puts a.get_last