module SessionsHelper
  #渡されたidでログインする
  def log_in(user)
    session[:user_id] = user.id
  end


  # 現在ログイン中のユーザーを返す
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end 

  #渡されたユーザーが正しいかを調べる  
  def current_user?(user)
    user && user == current_user
  end

  # ユーザーがログインしていればtrue、そうでないならfalseを返す
  def logged_in?
    !current_user.nil?
  end  

  #ログアウト用ヘルパー
  def log_out
    reset_session
    @current_user = nil
  end  


  #ログアウト
  #def log_out
    #forget(current_user)
    #reset_session
    #@current_user = nil
  #end  

 
end
