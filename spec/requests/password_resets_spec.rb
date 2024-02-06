require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  let(:user) { FactoryBot.create(:user) }
 
  before do
    ActionMailer::Base.deliveries.clear
  end

  describe 'new' do
    it 'contain name input tag' do
      get new_password_reset_path
      expect(response.body).to include "name=\"password_reset[email]\""
    end
  end 

  describe 'create' do
    it 'when invalid email display flash' do
      post password_resets_path, params: { password_reset: {email:' '}}
      expect(flash).to_not be_empty
    end

    context 'case in valid email' do
      it 'check reset_digest change' do
        post password_resets_path, params: { password_reset: { email: user.email } }
        expect(user.reset_digest).to_not eq user.reload.reset_digest

      end

      it 'add one email number' do
        expect{post password_resets_path,params: {password_reset:{email:user.email}}
      }.to  change(ActionMailer::Base.deliveries, :count).by 1
      end  

      it 'exist flash' do
        post password_resets_path, params:{password_reset:{email:user.email}}
        expect(flash).to_not be_empty
      end
      
      it 'redirect to home url' do
        post password_resets_path, params:{password_reset:{email:user.email}}
        expect(response).to redirect_to root_url
      end
    end
  end

  describe 'edit' do
    before do
      post password_resets_path, params: { password_reset: { email: user.email } }
      @user = controller.instance_variable_get('@user')
    end

    it 'if email and token are valid redirect to user page' do
      get edit_password_reset_path(@user.reset_token,email:@user.email)
      redirect_to @user
    end

    it 'if email are wrong redirect to root_path' do
      get edit_password_reset_path(@user.reset_token,email:'')
      expect(response).to redirect_to root_path
    end    

    it 'if account is invalid redirect to root_path' do
      @user.toggle!(:activated)
      get edit_password_reset_path(@user.reset_token,email:@user.email)
      expect(response).to redirect_to root_path
    end    

    it 'if token is invalid redirect to root_path' do
      get edit_password_reset_path('XXX',email:@user.email)
      expect(response).to redirect_to root_path
    end    
  end

  describe 'update' do
    before do
      post password_resets_path, params: { password_reset: { email: user.email } }
      @user = controller.instance_variable_get('@user')
    end
    
    context 'case in valid password' do
      it 'check change login status' do
        patch password_reset_path(@user.reset_token),params:  { email: @user.email,user: { password: 'password',password_confirmation: 'password' } }
        expect(logged_in?).to be_truthy
      end

      it 'check existance flash' do
        patch password_resets_path(@user.reset_token),params:  { email: @user.email,user: { password: 'password',password_confirmation: 'password' } }
        expect(flash).to_not be_empty
      end

      it 'check redirect to user page' do
        patch password_reset_path(@user.reset_token),params: { email: @user.email,user: { password: 'password',password_confirmation: 'password' } }
        expect(response).to redirect_to  @user
      end
    end 

    context 'case in invalid password' do
      it 'if password and confirmation are not equal express error message' do
        patch password_reset_path(@user.reset_token), params: { email: @user.email,user: { password: 'password',password_confirmation: 'password_cnf' } }
        expect(response.body).to include '<div id="error_explanation">'
      end


      it 'if password is empty express error message' do
        patch password_reset_path(@user.reset_token), params: { email: @user.email,user: { password: '',password_confirmation: '' } }
        expect(response.body).to include '<div id="error_explanation">'
      end
    end
  end  
end
