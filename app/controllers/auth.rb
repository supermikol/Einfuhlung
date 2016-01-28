get '/' do
  if request.xhr?
    erb :welcome, layout: false
  else
    erb :welcome
  end
end

get '/login' do
  if request.xhr?
    erb :login, layout: false
  else
    erb :login
  end
end

get '/signup' do
  erb :signup
end

get '/about' do
  if request.xhr?
    erb :about, layout: false
  else
    erb :about
  end
end

get '/contact' do
  if request.xhr?
    erb :contact, layout: false
  else
    erb :contact
  end
end

