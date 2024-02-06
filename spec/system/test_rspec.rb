require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    driven_by(:rack_test)
  end
  

  describe 'Post#delete' do
  before do
    log_in(user)
    
  end 

  it 'check display post delete button' do
   visit new_post_path
   fill_in 'post-content' ,with: 'xxx'
   click_button '投稿する'
   visit user_path user
   post = Post.first
   #click_on  '削除'
   expect {
    click_link '削除', href: post_path(post)
  }.to change(Post, :count).by -1

  end
  
  it '' do

 

  end
end
end