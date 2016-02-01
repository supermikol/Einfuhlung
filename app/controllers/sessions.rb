
get '/sessions/new' do
  if request.xhr?
    erb :"users/login", layout: false
  else
    erb :"users/login"
  end
end

post '/sessions/new' do
  if user = User.authenticate(email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect '/'
  else
    @error = "Incorrect password or email"
    erb :"users/login"
  end
end