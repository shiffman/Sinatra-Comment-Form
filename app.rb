require 'rubygems'
require 'bundler'
Bundler.require

set :root, File.dirname(__FILE__)

DataMapper::setup(:default, ENV['DATABASE_URL'] || {:adapter => 'yaml', :path => 'db'})

class Comment
  include DataMapper::Resource

  property :id,   Serial
  property :yourname, String
  property :presenter, String
  property :commenttext, Text
end

DataMapper.finalize

get '/comments' do
  # matches main route for the application, itp.nyu.edu/~irs221/sinatra/apt_listings/
  
  # Use these later in the erb file
  @allcomments = ''
  @total_comments = Comment.count
  
  for entry in Comment.all
    @allcomments += <<-HTML
      <p>#{entry.id},#{entry.yourname},#{entry.presenter},#{entry.commenttext}</p>
  HTML
  end
  
  # Show the html from views/index.erb
  erb :list
end



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