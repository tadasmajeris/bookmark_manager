ENV["RACK_ENV"] ||= "development"
require_relative "data_mapper_setup"
require 'sinatra/base'

class BookmarkManager < Sinatra::Base

  enable :sessions
  set :sessions_secret, 'super secret'

  helpers do
    def current_user
      @current_user ||=User.get(session[:user_id])
    end
  end

  get '/' do
    redirect '/links'
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    url = params['link_url']
    url = 'http://' + url unless url.include?('http://')
    link = Link.new(url: url, title: params['link_name'])
    params[:tags].split.each do |tag_name|
      link.tags << Tag.first_or_create(name: tag_name)
    end
    link.save
    redirect('/links')
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    user = User.create(email: params[:email],
                password: params[:password],
                password_confirmation: params[:password_confirmation])
    session[:user_id] = user.id
    redirect to('/links')
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
