require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let!(:restaurant) { FactoryBot.create(:restaurant2) }

  context "when not logged in" do
    it "does not create a like" do
      expect {
        post likes_path, params: { like: { user_id: restaurant.user.id, restaurant_id: restaurant.id } }
      }.to_not change(Like, :count)
    end

    it "redirects to the login page" do
      post likes_path, params: { like: { user_id: restaurant.user.id, restaurant_id: restaurant.id } }
      expect(response).to redirect_to login_path
    end
  end

  context "when logged in" do
    let(:user) { FactoryBot.create(:user2) }
    before { log_in(user) }

    it "creates a like and redirects to the restaurant page" do
      expect {
        post likes_path, params: { restaurant_id: restaurant.id  }
      }.to change(Like, :count).by(1)
      expect(response).to redirect_to restaurant_path(restaurant.id) 
    end
  end

  describe "DELETE /likes/:id" do
    let(:user) { FactoryBot.create(:user2) }
    let!(:restaurant) { FactoryBot.create(:restaurant2) }
    let!(:like)       { FactoryBot.create(:like, user: restaurant.user, restaurant: restaurant) }
    
    context "when not logged in" do
      it "does not delete the like" do
        expect {
          delete like_path(like)
        }.to_not change(Like, :count)
      end

      it "redirects to the login page" do
        delete like_path(like)
        expect(response).to redirect_to login_path
      end
    end

    before do
        # 所有者としてログイン
        log_in(owner)
      end

      it "deletes the like and redirects to the restaurant page" do
        expect {
          delete like_path(like), params: { restaurant_id: restaurant.id }
        }.to change(Like, :count).by(-1)
        expect(response).to redirect_to restaurant_path(restaurant.id)
      end
    end
  end
end
