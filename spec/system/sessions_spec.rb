require 'rails_helper'
 
RSpec.describe "Sessions", type: :system do
  before do
    driven_by(:rack_test)
  end
  
  describe '#new' do
    context 'valid case' do
      let(:user) { FactoryBot.create(:user) }
      it 'sucees login and check right link' do
        
        visit login_path
        fill_in 'sessions-email', with: user.email
        fill_in 'sessions-password', with: user.password
        click_button 'ログイン'
        expect(page).to have_selector "a[href=\"#{logout_path}\"]"
        expect(page).to have_selector "a[href=\"#{user_path(user)}\"]"
        expect(page).to_not have_selector "a[href=\"#{signup_path}\"]"
      end
    end 
    
    context 'invalid case' do  
      it 'can express flash' do
        visit login_path
        fill_in 'sessions-email', with: ' '
        fill_in 'sessions-password' , with: ' '
        click_button 'ログイン'
        expect(page).to have_selector 'div.alert.alert-danger'
        visit root_path
        expect(page).to_not have_selector 'div.alert.alert-danger'
      end
    end
  end
end  