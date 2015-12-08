require 'rubygems'
require 'sinatra'
require 'sass'
require './model/comment.rb'

helpers do
  include Rack::Utils; alias_method :h, :escape_html
end

get '/style.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :style
end

get '/' do
  @comments = Comment.order(:posted_date).reverse
  ###haml :index
end

put '/comment' do
  Comment.create({
    :name => request[:name],
    :title => request[:title],
    :message => request[:message],
    :posted_date => Time.now,
  })
  redirect '/'
end
