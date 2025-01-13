class SessionsController < ApplicationController


  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        reset_session
        log_in user
        redirect_to  user
      else 
        message = "アカウント作成が完了していません"
        message += "メールを確認して、アカウント作成が完了させてください"
        flash[:warning] = message
        redirect_to root_url
      end  
    else  
      flash.now[:danger] = 'メールアドレスかパスワードが間違っています'
      render 'new', status: :unprocessable_entity
    end  
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end  

    #ゲストログイン機能
    def guest_login
      user = User.find_or_create_by!(email: 'guestuser@restaurantchooser.com') do |user|
        user.name =  "ゲストユーザ"
        user.password_digest = SecureRandom.urlsafe_base64
        user.activated = "1"
      end
        reset_session
        log_in user
        redirect_to  user
    end
end
 