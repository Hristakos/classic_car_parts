#  Helper function
def logged_in? 
    !!session[:user_id]
end
# only works if logged in
def current_user
    find_a_user_by_id(session[:user_id])
end