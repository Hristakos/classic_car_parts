     
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'

require_relative 'models/listing'
require_relative 'models/user'
require_relative 'lib'

enable :sessions

get '/' do
  headline_query = ""
  sort_query = "price asc"


  if params[:headline] || params[:relevance]
    headline_query = params[:headline]
    sort_query = params[:relevance]
    # raise(headline_query + price_query)
  end
    listings = all_listings_by_query(headline_query,sort_query)
 
  erb(:index, locals: {listings:listings, headline: headline_query, sort_query:sort_query })
end
get '/listings/:id' do
 
  listing = find_a_listing_by_id(params[:id])
  erb(:show, locals:{listing:listing})
end
get '/user/listings' do
  headline_query = ""
  sort_query = "price asc"
  if params[:headline] || params[:relevance]
    headline_query = params[:headline]
    sort_query = params[:relevance]
  end
  redirect "/login" unless logged_in?
  listings = all_listings_for_user_by_query(current_user["id"], headline_query, sort_query)
  
  erb(:'listings/index', locals: {listings:listings, headline: headline_query, sort_query:sort_query })
end

get '/user/listings/new' do
  redirect "/login" unless logged_in?
  erb(:'listings/new')
end

get '/user/listings/:id/edit' do
  redirect "/login" unless logged_in?

  listing = find_a_user_listing_by_ids(params[:id], current_user["id"])
  if listing
    erb(:'listings/edit', locals:{listing:listing})
  else
    session[:user_id] = nil
    redirect '/login'
  end
  
end

get '/user/listings/:id' do
  redirect "/login" unless logged_in?
  listing = find_a_user_listing_by_ids(params[:id], current_user["id"])
  if listing
    erb(:'listings/show', locals:{listing:listing})
  else
    session[:user_id] = nil
    redirect '/login'
  end

end


post '/user/listings' do
  redirect "/login" unless logged_in?
  create_listing(params[:headline],
                        params[:description],
                        current_user["id"],
                        params[:suburb],
                        Time.now,
                        params[:price],
                        params[:file][:tempfile].path)
  redirect '/user/listings'
end

patch '/user/listings' do
  redirect "/login" unless logged_in?
  update_listing(params[:id],
                params[:headline],
                params[:description],
                params[:suburb],
                params[:price])
  redirect '/user/listings'
end

delete '/user/listings' do
  redirect "/login" unless logged_in?
  delete_listing(params[:id])
  redirect '/user/listings'
end

get '/login' do
   
  erb(:login)
end

post '/login' do

  user = find_a_user_by_email(params[:email])
  if user && BCrypt::Password.new(user["password_digest"]) == params[:password]
      session[:user_id] = user["id"]
      redirect "/"
  else
    erb(:login)
  end

end

delete '/logout' do
  session[:user_id] = nil
  redirect '/login'
end

get '/register' do
  msg = nil
  erb(:register, locals:{msg:msg})
end

post '/register' do
  user = find_a_user_by_email(params[:email])
  if user  
    msg = "user with email: #{params[:email]} already exists."
    return erb(:register, locals:{msg: msg })
  end
  create_user(params[:name],params[:email], params[:password])
  user = find_a_user_by_email(params[:email])
  if user
    session[:user_id] = user["id"]
    redirect '/'
  end
  redirect '/register'
end



