ENV["RACK_ENV"] ||= "development"
require_relative "data_mapper_setup"
require 'sinatra/base'

class BookmarkManager < Sinatra::Base
  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.new(url: params['link_url'], title: params['link_name'])
    tag = Tag.first_or_create(name: params[:tags])
    link.tags << tag
    link.save
    redirect('/links')
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
