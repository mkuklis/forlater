require 'rubygems'
require 'redis'

class Bookmarks
  
  def initialize
    @db = Redis.new({:host => '98.129.238.130', :port => 6379})
  end
  
  def get_all
   @db.list_range 'bookmarks', 0, -1
  end
  
  def add(value)
    @db.push_head 'bookmarks', fix_link(value)
  end
  
  def remove(value)
    @db.list_rm 'bookmarks', 1, value
  end
  
  def removeall()
    @db.list_trim 'bookmarks', 1, -1  
  end    

  private
  
  def fix_link(link)
    if link.match(/http:\/\/|https:\/\//).nil?
      link = 'http://' << link
    end
    link
  end

end
