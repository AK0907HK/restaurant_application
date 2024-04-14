class UsersController < ApplicationController
 
before_action :logged_in_user, only: [:edit,:update,:destroy]  
before_action :corrct_user, only:  [:edit,:update]  
before_action :check_admin, only: :destroy

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page:params[:page]) 
  end 

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.image.attach(params[:user][:image])
    if @user.save
      @user.send_activation_email 
      flash[:info] = "メールを確認して、アカウント作成を完了させてください。"
      redirect_to root_url
    else
      render 'new', status: :unprocessable_entity 
    end
  end   

  def edit
    @user = User.find(params[:id])
  end 

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "プロフィールを更新しました"
      redirect_to @user      
    else
      render 'edit', status: :unprocessable_entity
    end
  end  

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザー削除完了"
    redirect_to root_url 
  end   

  private
    #strongparameters
    def user_params
      params.require(:user).permit(:name, :email, :password,:password_confirmation,:image)
    end  

    #ログインしているユーザーが正しいか確認
    def corrct_user
      @user = User.find(params[:id])
      redirect_to(root_url, status: :see_other) unless current_user?(@user)
    end  

    #管理者であればtrueを返す
    def check_admin
      redirect_to(root_url, status: :see_other) unless current_user.admin?
    end  
end
