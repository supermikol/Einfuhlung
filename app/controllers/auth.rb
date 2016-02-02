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
  user = User.find(session[:user_id])
  all_heads = user.sent_messages.select {|message| message.head == true}
  all_heads.each do |message|
    if message.parent_message
      thread = [message.parent_message, message]
      temp_message = message
      until temp_message.children_messages.length == 0
        temp_message = temp_message.children_messages[0]
        thread <<  temp_message
      end
      @threads << thread
    else
      message.children_messages.each do |message|
        thread = [message.parent_message, message]
        temp_message = message
        until temp_message.children_messages.length == 0
          temp_message = temp_message.children_messages[0]
          thread <<  temp_message
        end
        @threads << thread
      end
    end
  end

  if request.xhr?
    erb :"/users/inbox", layout: false
  else
    erb :"/users/inbox"
  end
end