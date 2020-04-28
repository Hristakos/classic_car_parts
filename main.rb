     
require 'sinatra'
require 'sinatra/reloader'
require 'pg'

require_relative 'models/listing'

get '/' do
  listings = all_listings
  erb(:index, locals:{listings:listings})
end





