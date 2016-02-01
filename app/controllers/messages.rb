get '/messages/new' do
  erb :"messages/new"
end

post '/messages' do
  @message = Message.new(message: params[:text], sender_id: session[:user_id])
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
  @new_message = Message.new(message: params[:text], parent_id: params[:id], sender_id: session[:user_id])

  if @new_message.save
    redirect "/messages/#{params[:id]}"
  else
    @errors = @new_message.errors.full_messages
    erb :"/messages/reply"
  end
  erb :"/messages/show"
end

delete '/messages/:id' do
  Message.delete(params[:id])
  redirect '/'
end