require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    driven_by(:rack_test)
  end
   
  describe 'Users#show' do
    before do
      FactoryBot.send(:user_with_posts,posts_count:40)
      @user = Post.first.user  
      @user.password = 'user_password'
      log_in(@user)
      visit user_path @user
    end

    it 'check display posts number' do
      visit user_path @user
      check = 
        within 'ol.posts' do
            find_all('li')
        end
       expect(check.size).to eq 30 
    end    

    it 'check paginate tag' do
      visit user_path @user
      expect(page).to have_selector 'div.pagination'
    end  

    it 'check posts exist in user page' do
      visit user_path @user
      @user.posts.paginate(page:1).each do |post|
        expect(page).to have_content post.content 
      end  
    end 

  end  

  describe 'Post#create' do

    before do
      log_in(user)
      visit new_post_path
    end  


    context 'case in valid' do
      it 'check can post' do
        fill_in 'post-content' ,with: 'xxx'
        click_button '投稿する'
      end
    end

    context 'case in invalid' do
      it 'check can not post' do
        fill_in 'post-content' ,with: ''
        click_button '投稿する'
        expect(page).to have_selector 'div#error_explanation'
      end
    end     
  end  

  describe 'Post#delete' do

    before do
      log_in(user)
    end 
 
    it 'check display post delete button' do
      visit new_post_path
      fill_in 'post-name' ,with: 'aaa'
      fill_in 'post-content' ,with: 'xxx'
      click_button '投稿する'
      visit user_path user
      post = Post.first
      #click_on  '削除'
      expect {click_link '削除', href: post_path(post)}.to change(Post, :count).by -1
    end
   
    it 'other user can not delete post' do
      @other_user = FactoryBot.create(:user2)
      visit user_path(@other_user)
      expect(page).to_not have_link '削除'
    end
  end 

  describe 'Post#update' do

    before do
      log_in(user) 
    end 

    context 'case in valid' do
      it 'check can update post' do
        visit new_post_path
        fill_in 'post-name' ,with: 'aaa'
        fill_in 'post-content' ,with: 'xxx'
        click_button '投稿する'  
        post = Post.first 
        visit edit_post_path(post)
        fill_in 'post-content' ,with: 'yyy'
        click_button '編集する' 
        redirect_to user_path(user)
      end
    end    

    context 'case in non valid' do
      it 'check can not update' do
        visit new_post_path
        fill_in 'post-name' ,with: 'aaa'
        fill_in 'post-content' ,with: 'xxx'
        click_button '投稿する'  
        post = Post.first 
        visit edit_post_path(post)
        fill_in 'post-content' ,with: '  '
        click_button '編集する' 
        redirect_to edit_post_path(post)
      end
    end     

  end
end