require 'rubygems'
require 'bundler'
require 'sinatra'
require 'dm-core'
Bundler.require

set :root, File.dirname(__FILE__)

DataMapper::setup(:default, {:adapter => 'yaml', :path => 'db'})

class Comment
  include DataMapper::Resource

  property :id,   Serial
  property :yourname, String
  property :presenter, String
  property :commenttext, String
end

DataMapper.finalize


# Just the form
get '/' do
	erb :form
end

# Got some data
post '/' do

	@yourname = params[:yourname]
	@presenter = params[:presenter]
	@commenttext = params[:commenttext]

	# new comment
  	comment = Comment.new
  	comment.yourname = @yourname
  	comment.presenter = @presenter
  	comment.commenttext = @commenttext
  	comment.save

	erb :form
end