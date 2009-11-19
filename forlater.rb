require 'rubygems'
require 'sinatra'
require 'sass'
require 'haml'

require File.join(File.dirname(__FILE__), 'bookmark')

# configure redis
Bookmark.connect do |config|
  config[:host] = '98.129.238.130'
  config[:port] = 6379
end

# load css
get '/styles.css' do
  headers 'Content-Type' => 'text/css; charset=utf-8'
  sass :styles
end

get '/' do
  @bookmarks = Bookmark.list
  haml :index
end

post '/' do
  if !params[:url].empty?
    Bookmark.add(fix_link(params[:url]))
  end
  redirect '/'
end

get '/remove' do
  if !params[:url].empty?
    Bookmark.remove(params[:url])     
  end
  redirect '/'
end

get '/removeall' do
  Bookmark.remove_all()
end

helpers do
  def fix_link(link)
    if link.match(/http:\/\/|https:\/\//).nil?
      link = 'http://' << link
    end
    link
  end
end
