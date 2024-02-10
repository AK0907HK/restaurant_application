
require 'rails_helper'

RSpec.describe "Restaurants", type: :request do
  describe "create" do
    context 'case in not login' do
      it 'check can not add restaurant' do
        expect{post restaurants_path,params:{restaurant: {name:'xxxx',area1:1}}}
        .to_not change(Restaurant,:count)
      end

      it 'check redirect to loggin page' do
        post restaurants_path,params:{restaurant: {name:'xxxx',area1:1}}
        expect(response).to redirect_to login_path
      end
    end  
  end  

  describe '#destroy' do
    let(:user) { FactoryBot.create(:user2) }

    before do
      @restaurant = FactoryBot.create(:restaurant2)
    end  

    context 'case in other users resturant' do
      before do
        log_in(user)
      end

      it 'check restaurant is not deleted' do
        expect {delete restaurant_path(@restaurant)}.to_not change(Restaurant,:count)

      end

      #it 'check redirect to login page' do
        #delete restaurant_path(@restaurant)
        #expect(response).to redirect_to restaurants_path
      #end  
    end 

    context 'case in not login' do
      it 'check can not delete restaurant' do
        expect {delete restaurant_path(@restaurant)}.to_not change(Restaurant,:count)
      end
      
      it 'check redirect to login page' do
        delete restaurant_path(@restaurant)
        expect(response).to redirect_to login_path
      end  
    end  
  end  

  describe '#edit' do

    context 'case in not login' do
      let(:user) { FactoryBot.create(:user) }

      it '' do

      end  
    end
  end
end 
 