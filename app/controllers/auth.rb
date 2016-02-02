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
  @threads = Array.new
  @user = User.find(session[:user_id])
  @user.received_messages.each do |message|
  if message.children_messages.length == 0
    thread = [message]
    while message.parent_message
      message = message.parent_message
      thread << message
    end
    @threads << thread
  end
 end

  if request.xhr?
    erb :"/users/inbox", layout: false
  else
    erb :"/users/inbox"
  end
end