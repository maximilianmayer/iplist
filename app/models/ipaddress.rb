class Ipaddress < ActiveRecord::Base
  def self.search(searchip, searchdnsname)
    if searchip && searchip != ""
      if searchip.include? "%"
        find(:all, :conditions => ['address LIKE ?', "#{searchip}%"])
      else
        find(:all, :conditions => ['address = ?', "#{searchip}"])
      end
    else
      find(:all)
    end

    if searchdnsname && searchdnsname != ""
        find(:all, :conditions => ['hostname LIKE ?', "#{searchdnsname}"])
    else
      find(:all)
    end

  end

  def self.showonly(iptype)
    if iptype.include? "all"
      find(:all, :conditions => ['iptype LIKE ?', "%"])
    else
      find(:all, :conditions => ['iptype = ?', "#{iptype}"])
    end
  end

  def self.iptypes()
    #find("iptypes", :conditions => [])
  end

end
