require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get signup_path
      expect(response).to have_http_status(:ok)
    end
  end
  
  describe 'Post /users #create' do
    it 'invalid wrong information' do
      expect{
      post users_path,params: {user: {name: '  ',email:'xxx@email.com',
      password:'aaa', password_confirmation:'bbb'}}
    }.to_not change(User, :count)
    end
  

    context 'valid information' do
      let(:user_params){{user:{name: 'testuser',email: 'testuser@restaurant.com',
      password: 'password',password_confirmation:'password'
      }}}

      before do
        ActionMailer::Base.deliveries.clear
      end      

      it 'can enroll' do
        expect{
        post users_path, params: user_params
        }.to change(User,:count).by 1 
      end  

      it 'redirect to user page' do
        post users_path, params:user_params
        user = User.last
        #expect(response).to redirect_to user
      end

      it 'can express falsh' do
        post users_path,params: user_params
        expect(flash).to be_any
      end 

      it 'check login/logout status' do
        post users_path, params: user_params
        #expect(logged_in?). to be_truthy
      end
      
      it 'check mail exists' do
       post users_path, params: user_params 
       expect(ActionMailer::Base.deliveries.size).to eq 1
      end  

      it 'check not activated' do
        post users_path, params: user_params
        expect(User.last).to_not be_activated
      end

    end

  end

  describe 'get/users/{id}/edit' do
    let(:user){ FactoryBot.create(:user) }
    
    user2_params = {name:"mainuser2",email:"mainuser2@restaurantchooser.com" ,
    password:' ', password_confirmation: ''}

    it 'can access to user edit page' do
      log_in(user)
      get edit_user_path(user)
      expect(response.body).to include 'プロフィール変更'
    end
   
    context 'case not login' do
      it 'flash is not blank' do
        get edit_user_path(user)
        expect(flash).to_not be_empty
      end
   
      it 'when not login redirect to login page' do
        get edit_user_path(user)
        expect(response).to redirect_to login_path
      end

      it "redirect to edit page (friedlyforward function test)" do
        get edit_user_path(user)
        log_in(user)
        expect(response).to redirect_to edit_user_path(user)
      end  
    end

    context 'case other user'do

      it 'flash is empty' do
        log_in(user)
        patch user_path(user), params: { user: user2_params }
        expect(flash).to be_empty
      end  


    end
  end  

  describe 'PATCH/users' do
    let(:user){ FactoryBot.create(:user)}

    context 'invalid value case' do
      it 'can not value update' do
        log_in(user)
        patch user_path(user),params: {user:{ name:' ',email: '',
        password: 'aaa',password_confirmation: 'bbb'}}
        user.reload
        expect(user.name).to_not eq ''
        expect(user.email).to_not eq ''
        expect(user.password).to_not eq 'aaa'
        expect(user.password_confirmation).to_not eq 'bbb'
        expect(response.body).to include "プロフィール変更"
      end  
    end
          

    context 'valid value case' do
      before do
        @name = 'mainuser'
        @email = 'mainuser@restaurantchooser.com'
        log_in(user)
        patch user_path(user), params: {user: {name: @name,email: @email,
        password: ' ',password_confirmation:' '}}
      end  

      it 'can update information' do
        user.reload
        expect(user.name).to eq @name
        expect(user.email).to eq @email
      end  

      #it 'can redirect to user pages' do
        #expect(response).to redirect_to user
      #end
      
      #it 'flash is not blank' do
        #expect(flash).to be_any
      #end
    end


    

    context 'case not login' do
      it 'flash is not blank'do
        patch user_path(user),params: {user:{name:user.name,email:user.email}}
        expect(flash).to_not be_empty
      end

      it 'when not login redirect to login page' do
        patch user_path(user),params: {user:{name:user.name,email:user.email}}
        expect(response).to redirect_to login_path
      end
    end  

  end
 
  describe 'Likes' do
    let(:user){ FactoryBot.create(:user)}

      context 'case in not login' do
        it 'check can not access likes page' do
          get likes_path(user)
          expect(response).to redirect_to login_path
        end  
      end  

   
  end
end  
    

