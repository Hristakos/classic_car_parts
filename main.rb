     
require 'sinatra'
require 'sinatra/reloader'
require 'pg'

require_relative 'models/listing'

get '/' do
  listings = all_listings
  erb(:index, locals:{listings:listings})
end

get '/listings/new' do
  erb(:new)
end

get '/listings/:id/edit' do
  listing = find_a_listing_by_id(params[:id])
  erb(:edit, locals:{listing:listing})
end

get '/listings/:id' do
  listing = find_a_listing_by_id(params[:id])
  erb(:show, locals:{listing:listing})
end


post '/listings' do
  create_listing(params[:headline],params[:description])
  redirect '/'
end

patch '/listings' do

  update_listing( params[:id], params[:headline], params[:description])
  redirect '/'
end

delete '/listings' do
  delete_listing(params[:id])
  redirect '/'
end





