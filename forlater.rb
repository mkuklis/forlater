require 'rubygems'
require 'sinatra'
require File.join(File.dirname(__FILE__), 'bookmarks')

BOOKMARKS = Bookmarks.new

# load css
get '/styles.css' do
  header 'Content-Type' => 'text/css; charset=utf-8'
  sass :styles
end

get '/' do
  @bookmarks = BOOKMARKS.get_all();
  haml :index
end

post '/' do
  if (params[:url].nil?
    BOOKMARKS.add(params['url']);
  end
  
  redirect '/'
end
