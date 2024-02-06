require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { user.posts.build(name:"aaaa",content: "bbbb")}

  it 'valid post' do
    expect(post).to be_valid 
  end  

  it 'if user id is not exist post is invalid'do
    post.user_id = nil
    expect(post).to_not be_valid
  end

  it 'check posts sort' do
    FactoryBot.send(:user_with_posts)
    expect(FactoryBot.create(:most_recent)).to eq Post.first  
  end

  it 'if user deleted related posts delete' do
    post = FactoryBot.create(:most_recent)
    user = post.user
    expect{user.destroy}.to change(Post,:count).by -1
  end  

  describe 'content' do
    it 'if content is blank cannot post' do
      post.content = ''
      expect(post).to_not be_valid
    end

    it 'if name is blank cannot post' do
      post.name = ''
      expect(post).to_not be_valid
    end    

    it 'if coment has more than 300 words cannot post' do
      post.content = 'X' * 301
      expect(post).to_not be_valid 
    end

    it 'if name has more than 50 words cant post' do
      post.name = 'X' * 51
      expect(post).to_not be_valid 
    end
  end  
end
