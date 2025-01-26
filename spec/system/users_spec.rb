RSpec.describe "Users", type: :system do
    before do
      driven_by(:rack_test)
    end

    it "is connected" do
      expect(ActiveRecord::Base.connected?).to eq(true)
    end
    
    
    describe '#create' do
      context '無効な値の場合' do
        it 'エラーメッセージ用の表示領域が描画されていること' do
          visit signup_path
          fill_in 'user-name', with: ''
          fill_in 'user-email', with: 'user@invlid'
          fill_in 'user-password', with: 'foo'
          fill_in 'user-password-cmf', with: 'bar'
          click_button 'ユーザー登録'
    
          expect(page).to have_selector 'div#error_explanation'
          expect(page).to have_selector 'div.field_with_errors'
        end
      end
    end
   end