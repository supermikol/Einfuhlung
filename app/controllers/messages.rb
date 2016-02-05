get '/messages/new' do
  erb :"messages/new"
end

#Create initial post
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

#Shows posting
get '/messages/:id' do
  @message = Message.find(params[:id])
  erb :"/messages/show"
end

#reply page to post
get '/messages/:id/reply' do
  @message = Message.find(params[:id])
  erb :"/messages/reply"
end

#Post first reply to post
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


get '/messages/threads/:id/window' do
  @thread_num = params[:id]
  @threads = Array.new
  all_heads = User.find(session[:user_id]).head_messages

  #stores entire threads of every head message intos @threads
  all_heads.each do |message|
    @threads += message.return_threads
  end

  # thread = @threads[@thread_num.to_i]
  erb :"/users/_msg", layout: false, locals: {thread: @threads[@thread_num.to_i]}
end


get '/messages/threads/:id' do
  @thread_num = params[:id]

  @threads = Array.new
  all_heads = User.find(session[:user_id]).head_messages

  #stores entire threads of every head message intos @threads
  all_heads.each do |message|
    @threads += message.return_threads
  end

  erb :"/users/_thread", layout: false

end

#reply in conversation
post '/messages/private/:id' do
  @new_message = Message.new(message: params[:text], parent_id: Message.find(params[:id]).last_child_id, sender_id: session[:user_id])


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
