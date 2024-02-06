require 'rails_helper'

RSpec.describe "Likes", type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    driven_by(:rack_test)
  end
    
  describe '#create' do
    context 'case in can login ' do
      before do
        log_in(user)
        visit new_post_path
        fill_in 'post-name' ,with: 'aaaa'
        fill_in 'post-content' ,with: 'xxxx'
        click_button '投稿する'
      end

      it 'check aviable like function' do
        visit user_path user
        click_on  "♥"
        visit likes_path user
        click_on  "♥"
      end
    end
  end
end
