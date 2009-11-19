require 'rubygems'
require 'sinatra'
require 'sass'
require 'haml'
require File.join(File.dirname(__FILE__), 'bookmarks')

BOOKMARKS = Bookmarks.new

# load css
get '/styles.css' do
  headers 'Content-Type' => 'text/css; charset=utf-8'
  sass :styles
end

get '/' do
  @bookmarks = BOOKMARKS.get_all()
  haml :index
end

post '/' do
  if !params[:url].empty?
    BOOKMARKS.add(params[:url])
  end
  redirect '/'
end

get '/remove' do
  if !params[:url].empty?
    BOOKMARKS.remove(params[:url])     
  end
  redirect '/'
end

get '/removeall' do
  BOOKMARKS.removeall()
end
