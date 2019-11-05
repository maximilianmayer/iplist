require_relative 'app'

#use Rack::Profiler if ENV['RACK_ENV'] == 'development'
run IPAM::Webapp
