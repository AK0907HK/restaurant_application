require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get login_path
      expect(response).to have_http_status :success
    end
  end

  describe 'create' do
    let(:user){ FactoryBot.create(:user) }

    it 'remember_token=1 and cookies values are not empty' do
      post login_path, params: {session:{email:user.email,password:user.password}}
      expect(session[:user_id]).to eq(user.id)
    end   
  end  

  describe 'DELETE /logout' do
    before do
      user = FactoryBot.create(:user)
      post login_path, params: {session: {email: user.email, password: user.password}}
    end  

    it 'can logout' do
      expect(logged_in?).to be_truthy
      delete logout_path
      expect(logged_in?).to_not be_truthy
    end

    it 'can not logout twice' do
      delete logout_path
      delete logout_path
      expect(response).to redirect_to root_path
    end  
  end
end
