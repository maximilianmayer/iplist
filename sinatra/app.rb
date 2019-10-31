#
require 'sinatra'
require 'sinatra/contrib'
require 'sinatra/partial'
require 'erb'

class Iplist < Sinatra::Base
  configure do
    register Sinatra::Partial
    register Sinatra::Reloader
    enable :partial_underscores
    set :partial_template_engine, :erb
    after_reload do
      puts 'reloaded'
    end
  end

  get '/' do
    search = partial :"partials/search"
    nav = partial :'partials/navigation'
    ips = [ {id: 0, address: '10.1.1.1', subnet: '/16', hostname: 'test.local', iptype: 'used'} ]
    puts ips
    erb :index, :locals => {:search => search , :navigation => nav, :ips => ips}
  end

end