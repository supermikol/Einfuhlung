get '/messages/new' do
  erb :"messages/new"
end

post '/messages' do
  @message = Message.new(
    message: params[:text],
    sender_id: session[:user_id],
    head: true)
  if @message.save
    redirect "/messages/#{@message.id}"
  else
    @errors = @message.errors.full_messages
    erb :"messages/new"
  end
end

get '/messages/:id' do
  @message = Message.find(params[:id])

  erb :"/messages/show"
end

get '/messages/:id/reply' do
  @message = Message.find(params[:id])
  erb :"/messages/reply"
end


post '/messages/:id' do
  @message = Message.find(params[:id])
  @new_message = Message.new(message: params[:text], parent_id: params[:id], sender_id: session[:user_id],
    head: true)

  if @new_message.save
    redirect "/messages/#{params[:id]}"
  else
    @errors = @new_message.errors.full_messages
    erb :"/messages/reply"
  end

end

get '/messages/threads/:id' do
  @thread_num = params[:id]

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

  erb :"/users/_thread", layout: false

end

post '/messages/private/:id' do
  @new_message = Message.new(message: params[:text], parent_id: params[:id], sender_id: session[:user_id])


  if @new_message.save
    if request.xhr?
      redirect "/messages/threads/#{params[:thread_id]}"
      # erb :"/users/_thread", layout: false
    end
  else
    @errors = @new_message.errors.full_messages
    redirect "/inbox"
  end

end

delete '/messages/:id' do
  Message.delete(params[:id])
  redirect '/'
end