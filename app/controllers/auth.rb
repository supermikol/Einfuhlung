get '/' do
  if request.xhr?
    erb :index, layout: false
  else
    erb :index
  end
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

get '/inbox' do
  if request.xhr?
    erb :"/users/inbox", layout: false
  else
    erb :"/users/inbox"
  end
end