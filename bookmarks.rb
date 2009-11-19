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
    @db.push_head 'bookmarks', value
    # "puts
  end
  
  def remove(index)
    @db.list_trim 'bookmarks', index-1, index
  end

end
