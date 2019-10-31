module IpaddressesHelper
  def bttn_back_to_index
    content_tag(:div, link_to("back", :action => "index"), :class => "nav_button")
  end
  def bttn_edit_ip
    content_tag(:div, link_to("edit", :action => "edit", :id => @ips.id), :class => "nav_button")
  end
  def bttn_edit_sub
    content_tag(:div, link_to("edit", :action => "editsub", :id => @ipsubs.id), :class => "nav_button")
  end
  def nav_end
    content_tag(:div, '', :class => "nav_end")
  end
end
