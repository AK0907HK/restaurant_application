class PostsController < ApplicationController
   
    before_action :logged_in_user, only: [:new,:create,:edit,:update,:destroy,:search,:search_form]
    before_action :check_user ,only: [:edit,:update,:destroy]
    
    def new
      @post = current_user.posts.build
    end    
  
    def create
      @post = current_user.posts.build(post_params)
      #@post.images.attach(params[:post][:images])
      if @post.save
        flash[:success] = "ポストを投稿しました"
        redirect_to user_path current_user
      else
        render '/posts/new', status: :unprocessable_entity
      end
    end

    def edit
      @post = Post.find_by(id: params[:id])

    end
    
    def update
      @post = Post.find_by(id: params[:id])
      if @post.update(post_params)
        flash[:success] = "ポスト更新に成功しました！"
        redirect_to user_path current_user
      else
        render 'edit', status: :unprocessable_entity
      end  
    end  

    def search
      @content = params[:content] 
      @posts_list = Post.search_for(@content) 
      @posts = @posts_list.paginate(page:params[:page])  
    end  

    def search_form   
      @posts = Post.all.paginate(page:params[:page])   
    end  

  
  
    def destroy
      @post.destroy
      flash[:success] = "ポストを削除しました"
      redirect_to user_path current_user
    end
  
    private
      
      #strongparameter
      def post_params
        #params.require(:post).permit(:name,:content,images: [])
        params.require(:post).permit(:content,images: [])
      end

      #ユーザー確認
      def check_user
        @post = current_user.posts.find_by(id:params[:id])
        redirect_to users_path, status: :see_other if @post.nil?
      end  
  end
  