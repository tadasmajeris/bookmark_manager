require 'sinatra/base'
require_relative 'models/link'

class BookmarkManager < Sinatra::Base
  before do
    DataMapper.setup(:default, "postgres://localhost/bookmark_manager_test")
    DataMapper.finalize
  end

  get '/links' do
    @links = Link.all
    erb(:'links/index')
  end

  post '/links' do
    Link.create(url: params[:url], title: params[:title])
    DataMapper.auto_upgrade!
    redirect '/links'
  end

  get '/links/new' do
    erb(:'links/new')
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
