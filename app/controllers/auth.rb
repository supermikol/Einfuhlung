get '/' do
  @sorted_messages = Message.all.sort_by{|x| x.created_at}.reverse
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
  user = User.find(session[:user_id])

  @threads = Array.new
  all_heads = User.find(session[:user_id]).head_messages

  #stores entire threads of every head message intos @threads
  all_heads.each do |message|
    @threads += message.return_threads
  end

  if request.xhr?
    erb :"/users/inbox", layout: false
  else
    erb :"/users/inbox"
  end
end
