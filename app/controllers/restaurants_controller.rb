class RestaurantsController < ApplicationController
 
  before_action :logged_in_user, only: [:index,:new,:create,:edit,:update,:destroy,:choose_form,:choose,:search_form,:search]
  before_action :correct_user ,only: [:edit,:update,:destroy]
  
  #一覧の表示
  def index 
    @user = User.find_by(id:current_user.id)
    @restaurants = @user.restaurants.paginate(page: params[:page])
  end

  def show
    @restaurant = Restaurant.find_by(id:params[:id])
  end 
  
   
  def new
    @restaurant =  current_user.restaurants.build
  end
  
  def create
    @prefecture = Area1.all
    @restaurant =  current_user.restaurants.build(restaurant_params)
    @restaurant.image.attach(params[:restaurant][:image])
    if @restaurant.save
      flash[:success] = "お店のリストを追加しました！"
      redirect_to restaurants_path
    else
      render 'new', status: :unprocessable_entity
    end  
  end



  def edit
    @restaurant = Restaurant.find_by(id: params[:id])
  end  

  def update
    @restaurant = Restaurant.find_by(id: params[:id])
    if @restaurant.update(restaurant_params)
      flash[:success] = "お店情報を更新しました!"
      redirect_to restaurants_path
    else
      render 'edit', status: :unprocessable_entity
    end         
  end  

  def choose_form
    @user = User.find_by(id:current_user.id)
    @restaurants = @user.restaurants.paginate(page: params[:page])
  end
  
  def choose
    @area1 = params[:area1] 
    @area2 = params[:area2] 
    @time = params[:time] 
    @genre = params[:genre] 
    @restaurants = Restaurant.choose_for(@area1,@area2,@time,@genre,current_user.id )
    @rand = rand(@restaurants.count)                  
    @restaurant = @restaurants[@rand]
  end  

  def search
    @area1 = params[:area1] 
    @area2 = params[:area2] 
    @time = params[:time]  
    @genre = params[:genre] 
    @restaurants_list = Restaurant.search_for(@area1,@area2,@time,@genre) 
    @restaurants = Restaurant.all.paginate(page: params[:page])
  end  

  def search_form     
    @restaurants = Restaurant.all.paginate(page: params[:page])
  end 

 

  def destroy
    @restaurant.destroy
    flash[:success] = "お店を削除しました"
    redirect_to restaurants_path
  end  



  
  private
      
  #strongparameter
  def restaurant_params
    params.require(:restaurant).permit(:name,:area1,:area2,:time,:genre,:coment,:lat,:lng)

  end

  #ユーザー確認
  def correct_user
    @restaurant = current_user.restaurants.find_by(id:params[:id])
    redirect_to user_path(current_user), status: :see_other if @restaurant.nil?
  end 
end
