class IpaddressesController < ApplicationController
  def index
    @all_ips = Ipaddress.find(:all)
    #@all_iptypes = Ipaddress.find(:iptype).map(&:iptype).uniq

    if !params[:searchip] && !params[:searchdnsname]
      @ips = @all_ips
    elsif params[:searchip]  && !params[:searchdnsname]
      @ips = Ipaddress.search(params[:searchip],nil)
    elsif
      @ips = Ipaddress.search(nil,params[:searchdnsname])
    else
      @ips = Ipaddress.search(params[:searchip],params[:searchdnsname])
    end
  end
  #if params[:iptype]
  #  @ips = Ipaddress.showonly(params[:iptype])
  #end

  def edit
    @ips = Ipaddress.find(params[:id])
  end

  def update
    @ips = Ipaddress.find(params[:id])
    if @ips.update_attributes(params[:ipaddress])
      flash[:notice] = "Entry successfully updated."
      redirect_to :action => "index"
    else
      render :action => "edit"
    end
  end

  def new
    @ips = Ipaddress.new
    @ip_types = ["used", "reserved", "free"]
  end

  def create
    @ips = Ipaddress.new(params[:ipaddress])
    if @ips.save
      flash[:notice] = "Entry successfully created."
      redirect_to :action => "index"
    else
      render :action => "new"
    end
  end

  def show
    @ips = Ipaddress.find(params[:id])
  end

  def listsub
    @ipsubs = Subnet.find(:all)
  end

  def newsub
    @ipsubs = Subnet.new
  end

  def showsub
    @ipsubs = Subnet.find(params[:id])
  end

  def createsub
    @ipsubs = Subnet.new(params[:subnet])
    if @ipsubs.save
      flash[:notice] = "Subnet was created successfully."
      redirect_to :action => "listsub"
    else
      render :action => "newsub"
    end
    #ip_first = @ipsubs.ip_start.split(".").first
    #ip_last = @ipsubs.ip_end.split(".").last
    #until $ip_first > $ip_last do
    #  Ipaddress.new("","#{$ip_first}", @ipsubs.mask,"")
    #  $ip_first +=1;
    #end
  end

  def editsub
    @ipsubs = Subnet.find(params[:id])
  end

  def updatesub
    @ipsubs = Subnet.find(params[:id])
    if @ipsubs.update_attributes(params[:subnet])
      flash[:notice] = "Subnet successfully updated."
      redirect_to :action => "listsub"
    else
      render :action => "editsub"
    end
  end

  def discover_net
    network = params[:discovernet].split('.')
    @network_base = network[0,3].map{ |i| i.to_s }.join(".") + "."
    @scan_host_start = 2
    @scan_host_end = 254
    @scan_ip_start = @network_base + @scan_host_start.to_s
    @scan_ip_end = @network_base + @scan_host_end.to_s
  end
end
