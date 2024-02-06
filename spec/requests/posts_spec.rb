require 'rails_helper'
 
RSpec.describe "Posts", type: :request do
  describe 'Posts#create' do
    context 'case in not login' do
      it 'check can not add posts number' do
        expect{ post new_post_path, params: { post: { name:"aaaa",content: 'xxxxx' }} }.to_not change(Post, :count)
      end

      it 'check redirect to login page' do
        post posts_path, params: {post: { name:"aaaa",content: 'xxxxx' }}
        expect(response).to redirect_to login_path
      end  
    end
  end 

  describe '#destroy' do
    let(:user) { FactoryBot.create(:user2) }

    before do
      @post = FactoryBot.create(:most_recent)
    end    
    
    context 'case in delete other users post' do
      before do
        log_in(user)
      end  
        
      it 'check can not delete post' do    
        expect{delete posts_path(@post)}.to_not change(Post,:count) 
      end
      
      #it 'check redirect to login page' do
        #delete post_path(@post)
        #expect(response).to redirect_to users_path
      #end  

    end    

    describe 'Posts#update' do
      context 'case in not login' do
        let(:user) { FactoryBot.create(:user) }

        it 'check redirect to login page' do
          log_in(user)
          post new_post_path, params: { post: { name:"aaaa",content: 'xxxxx' }}
          @post_new = Post.first
          get edit_post_path @post_new
          post edit_post_path, params: { post: { name:"bbbb",content: 'yyyyy' }}
          redirect_to user_path(user)
        end  
      end 
    end
  end  
end   