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
      erb :index
    end

    get '/ip' do
      search = partial :"partials/search"
      nav = partial :'partials/navigation'
      #ips = [ {id: 0, address: '10.1.1.1', subnet: '/16', hostname: 'test.local', iptype: 'used'} ]
      ips = db_ips.get_all
      # puts ips
      erb :ips, :locals => {:search => search , :navigation => nav, :ips => ips}
    end

    # get '/subnet' do
    # end

    post '/ip/add' do
      id = db_ips.get_last
      ip = IPAddr.new(params['ip'])
      puts ip.to_s
      data = {'ip' => ip, 'netmask' => ip.prefix, 'hostname' => params['hostname'], 'type' => params['iptype'], 'comment' => params['comment']}
      db_ips.write(data)
      redirect '/'
    end

  end
end