require 'sinatra/base'
require 'data_mapper'

class BookmarkManager < Sinatra::Base
  get '/' do

  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
