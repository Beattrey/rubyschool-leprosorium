#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database,{ adapter: "sqlite3", database: "leprosorium.db" }

class Post < ActiveRecord::Base
  has_many :comments
  validates :author, presence: true
  validates :content, presence: true
end

class Comment < ActiveRecord::Base
  belongs_to :post
  validates :name, presence: true
  validates :comment, presence: true
end


get '/' do
  @posts = Post.all
  erb :index
end

get '/new' do
  @p = Post.new
  erb :new
end

post '/new' do
  @p = Post.new params[:post]
  @p.save

  if @p.save
    erb "<p>Post added</p>"
  else
    @error = @p.errors.full_messages.first
    erb :new
  end
end

get '/details/:id' do
  @post = Post.find(params[:id])
  @comments = Comment.where(post_id: @post.id)
  erb :details
end

post '/details/:id' do
  # @comment = Comment.find(params[:id])
  @post = Post.find(params[:id])

  @c = Comment.new params[:comment]
  @c.post_id = @post[:id]
  @c.save

  if @c.save
    erb "<p>Comment added</p>"
  else
    @c.errors.full_messages.first
    erb :details
  end

end
