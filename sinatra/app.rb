#
require 'sinatra'
require 'sinatra/contrib'
require 'sinatra/partial'
require 'sinatra/reloader' if development?
require "sinatra/config_file"
require 'erb'
require 'ipaddr'
require 'resolv'
require_relative 'lib/db'

module IPAM
  class Webapp < Sinatra::Base
    configure do
      register Sinatra::Partial
      register Sinatra::ConfigFile

      enable :partial_underscores
      set :partial_template_engine, :erb
      config_file './config.yml'
      puts settings.db
    end

    db = IPAM::Sqlite.new 'ipam'


    def scan_net()

    end

    get '/' do
      search = partial :'partials/search'
      nav = partial :'partials/navigation'
      erb :index, :locals => {:search => search , :navigation => nav}

    end

    get '/ip' do
      search = partial :"partials/search"
      nav = partial :'partials/navigation'
      #ips = [ {id: 0, address: '10.1.1.1', subnet: '/16', hostname: 'test.local', iptype: 'used'} ]
      ips = db.get_all_ips
      # puts ips
      erb :ips, :locals => {:search => search , :navigation => nav, :ips => ips, :networks => [{ 'id' => 0 , 'name' => 'default'}] }
    end

    get '/network' do
      search = partial :"partials/search"
      nav = partial :'partials/navigation'
      erb :network, :locals => {:search => search , :navigation => nav}
    end

    get '/location' do
      search = partial :"partials/search"
      nav = partial :'partials/navigation'
      erb :location, :locals => {:search => search , :navigation => nav}
    end

    get '/ip/:network' do
      db.get_all_ips paras[:network]
      erb
    end

    post '/ip/add' do
      id = db.get_last_id
      ip = IPAddr.new(params['ip'])
      if ip.ipv4? && ip.prefix < 32
        ip.to_range.each do |i|
          data = []
          data.push ({'ip' => i, 'netmask' => i.prefix, 'hostname' => '', 'type' => 'free' ,'comment' =>'', 'network' => params['hostname'], 'location' => params['location'] })
          db.write(data)
        end

      else
        data = {'ip' => ip, 'netmask' => ip.prefix, 'hostname' => params['hostname'], 'type' => params['iptype'],'comment' => params['comment'], 'network' => params['network'], 'location' => params['location'] }
        db.write(data)
      end
      redirect '/ip'
    end

  end
end