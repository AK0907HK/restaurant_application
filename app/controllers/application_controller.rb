class ApplicationController < ActionController::Base
    include SessionsHelper 
   
    
    #protect_from_forgery with: :null_session
    #skip_before_action :verify_authenticity_token
    
    private
  
      #ログインしているかを確認
      def logged_in_user
        unless logged_in?
          store_url
          flash[:danger] = "ログインしてください"
          redirect_to login_url, status: :see_other
        end
      end  
  
  end
  