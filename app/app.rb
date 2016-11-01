ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require_relative 'data_mapper_setup'
require_relative 'server'
require_relative 'controllers/links'
require_relative 'controllers/sessions'
require_relative 'controllers/users'
require_relative 'controllers/tags'
require_relative './../lib/send_recovery_link'

class BookmarkManager < Sinatra::Base

  get '/' do
    redirect '/links'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
