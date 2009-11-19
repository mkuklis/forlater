require 'rubygems'
require 'redis'

module BaseList
  
  def connect
    configure
    yield @@configuration if block_given?
    @db = Redis.new(@@configuration)
  end
  
  def configure
    @@configuration = {
      :host => 'localhost',
      :port => 6379
    }
  end
  
  # retrieve list
  def list
   @db.list_range self.class.name, 0, -1
  end
  
  # add to list
  def add(value)
    @db.push_head self.class.name, value
  end
  
  # remove value from list
  def remove(value)
    @db.list_rm self.class.name, 1, value
  end
  
  # remove all
  def remove_all()
    @db.list_trim self.class.name, 1, -1  
  end
end