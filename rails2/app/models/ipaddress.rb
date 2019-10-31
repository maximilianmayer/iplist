class Ipaddress < ActiveRecord::Base
  def self.search(searchip, searchdnsname)
    if searchip && searchdnsname
      if searchip != "" && searchdnsname != ""
        result = Ipaddress.find(:all, :conditions => ['address LIKE ? AND hostname LIKE ?',"#{searchip}%", "#{searchdnsname}%"])
      elsif searchip != ""
        if searchip.include? "%"
          result = Ipaddress.find(:all, :conditions => ['address LIKE ?', "#{searchip}%"])
        end
      elsif searchdnsname != ""
          result = Ipaddress.find(:all, :conditions => ['hostname LIKE ?', "#{searchdnsname}%"])
      else
        result = Ipaddress.find(:all)
      end
    end
    return result
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
