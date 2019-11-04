#
require 'sinatra'
require 'sinatra/contrib'
require 'sinatra/partial'
require 'sinatra/reloader' if development?
require 'erb'
require 'ipaddr'
require 'resolv'
require_relative 'db'

module IPlist
  class Webapp < Sinatra::Base
    configure do
      register Sinatra::Partial
      enable :partial_underscores
      set :partial_template_engine, :erb
    end

    db_ips = IPlist::DB.new 'ipaddresses'


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
      ips = db_ips.get_all
      # puts ips
      erb :ips, :locals => {:search => search , :navigation => nav, :ips => ips}
    end

    #get '/subnet' do
    # end

    post '/ip/add' do
      id = db_ips.get_last
      ip = IPAddr.new(params['ip'])
      if ip.ipv4? && ip.prefix < 32
        ip.to_range.each do |i|
          data = {'ip' => i, 'netmask' => i.prefix, 'hostname' => '', 'type' => 'free' ,'comment' =>'', 'network' => params['hostname'], 'location' => params['location'] }
          db_ips.write(data)
        end

      else
        data = {'ip' => ip, 'netmask' => ip.prefix, 'hostname' => params['hostname'], 'type' => params['iptype'],'comment' => params['comment'], 'network' => params['network'], 'location' => params['location'] }
        db_ips.write(data)
      end
      redirect '/ip'
    end

  end
end