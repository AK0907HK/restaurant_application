class PasswordResetsController < ApplicationController

  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_time,  only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email:params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "パスワード変更用のメールを送信しました"
      redirect_to root_url
    else
      flash.now[:danger] = "メールアドレスが存在しません"
      render 'new', status: :unprocessable_entity
    end  
  end  

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password,"パスワードを入力してください")
      render 'edit', status: :unprocessable_entity
    elsif @user.update(user_params)
      reset_session
      log_in(@user)
      flash[:success] = "パスワード変更が完了しました"
      redirect_to @user      
    else  
      render 'edit', status: :unprocessable_entity 
    end 
  end  

  private
    #strong_parameter
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    #ユーザー情報を取得
    def get_user
      @user = User.find_by(email:params[:email])
    end 

    #ユーザーが正しいか確認する
    def valid_user
      unless ( @user && @user.activated? && @user.authenticated?(:reset, params[:id]) )
        redirect_to root_url
      end  
    end  

    #トークン(パスワード変更)の期限を確認する
    def check_time
      if @user.password_reset_expired?
        flash[:danger] = 'パスワード変更の期限が切れています'
        redirect_to new_password_reset_url
      end  
    end  
end
