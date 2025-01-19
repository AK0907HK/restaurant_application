class LikesController < ApplicationController
 
  before_action :logged_in_user, only: [:index,:create,:destroy]
  before_action :correct_user ,only: [:index,:create,:destroy]

  def index
    @user = User.find_by(id:current_user.id)
    #user_id = @user.id
    @likes = @user.likes.paginate(page:params[:page]) 
    #@likes = Like.where(user_id:user_id)
    #@posts = Post.where(user_id:like_user_id) 
  end
    
  def create
    #@like = Like.new(user_id: current_user.id,post_id:params[:post_id])
    @like = Like.new(user_id: current_user.id,restaurant_id:params[:restaurant_id])
    @like.save
    redirect_to restaurant_path(@like.restaurant_id)
  end

  def destroy 
    #@like = Like.find_by(user_id: current_user.id, post_id:params[:post_id])
    @like = Like.find_by(user_id: current_user.id, restaurant_id:params[:restaurant_id])
    @like.destroy
    redirect_to restaurant_path(@like.restaurant_id)
  end  

  private
    
    #いいねをするユーザーが正しいかを確認
    def correct_user
      user_id = current_user.id
      @user = User.find_by(id:user_id)
      redirect_to login_path  if @user.nil?
    end

end