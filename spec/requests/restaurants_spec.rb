
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

  describe "DELETE /likes/:id" do
    let!(:restaurant) { FactoryBot.create(:restaurant2) }
    let!(:like) { FactoryBot.create(:like, user: restaurant.user, restaurant: restaurant) }

    context "when not logged in" do
      it "does not delete the like" do
        expect {
          delete like_path(like), params: { restaurant_id: like.restaurant_id }
        }.to_not change(Like, :count)
      end

      it "redirects to the login page" do
        delete like_path(like), params: { restaurant_id: like.restaurant_id }
        expect(response).to redirect_to login_path
      end
    end

    context "when logged in as a non-owner" do
      let(:other_user) { FactoryBot.create(:user2) }
      before { log_in(other_user) }

      it "does not delete the like" do
        expect {
          delete like_path(like), params: { restaurant_id: like.restaurant_id }
        }.to_not change(Like, :count)
      end

      it "redirects to the restaurant page" do
        delete like_path(like), params: { restaurant_id: like.restaurant_id }
        expect(response).to redirect_to restaurant_path(restaurant)
      end
    end

    context "when logged in as the owner" do
      let(:owner) { restaurant.user }
      before { log_in(owner) }

      it "deletes the like" do
        expect {
          delete like_path(like), params: { restaurant_id: like.restaurant_id }
        }.to change(Like, :count).by(-1)
      end

      it "redirects to the restaurant page" do
        delete like_path(like), params: { restaurant_id: like.restaurant_id }
        expect(response).to redirect_to restaurant_path(restaurant)
      end
    end
  end
end
  
  end
end 
 