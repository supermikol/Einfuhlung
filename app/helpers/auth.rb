helpers do

  def current_user
    if session[:user_id]
      return User.find(session[:user_id])
    else
      return nil
    end
  end

  def logout
    session[:user_id] = nil
  end

end