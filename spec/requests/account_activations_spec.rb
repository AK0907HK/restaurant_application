require 'rails_helper'

RSpec.describe "AccountActivations", type: :request do
  describe '/account_activations/{id}/edit' do

    before do
      post users_path,params: {user:{name:'account_activation',email:'account_activation@restaurantchooser.com',
      password:'activation_password',password_confirmation:'activation_password'}}
      @user = controller.instance_variable_get('@user')
    end
    
    context 'case in valid email and token' do
      it 'can activation' do                   
        get edit_account_activation_path(@user.activation_token, email: @user.email)
        @user.reload
        expect(@user).to be_activated
      end

      it 'can change login status' do
        get edit_account_activation_path(@user.activation_token, email: @user.email)
        expect(logged_in?).to be_truthy
      end

      it 'can display users page' do
        get edit_account_activation_path(@user.activation_token, email: @user.email)
        expect(response).to redirect_to user_path(@user)
      end  
    end
    
    context 'case in invalid email and token' do
      it 'can not change login stauts due to invalid token' do
        get edit_account_activation_path('invalid',email:@user.email)
        expect(logged_in?).to be_falsey
      end  

      it 'can not change login stauts due to invalid email' do
        get edit_account_activation_path(@user.activation_token,email:'xxx')
        expect(logged_in?).to be_falsey
      end
    end  
    
  end
end
