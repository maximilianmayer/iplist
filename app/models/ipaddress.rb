class Ipaddress < ActiveRecord::Base
  def self.search(searchip, searchdnsname)
    if searchip && searchdnsname
      if searchip != "" && searchdnsname != ""
        find(:all, :conditions => ['address LIKE ? AND hostname LIKE ?',"#{searchip}%", "#{searchdnsname}%"])
      elsif searchip != ""
        if searchip.include? "%"
          find(:all, :conditions => ['address LIKE ?', "#{searchip}%"])
        end
      elsif searchdnsname != ""
          find(:all, :conditions => ['hostname LIKE ?', "#{searchdnsname}%"])
      else
        find(:all)
      end
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
