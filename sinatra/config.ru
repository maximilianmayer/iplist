require_relative 'app'

#use Rack::Profiler if ENV['RACK_ENV'] == 'development'
use Rack::Reloader, 0
run Iplist
