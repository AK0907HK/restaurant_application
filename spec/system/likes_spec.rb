require 'rails_helper'

RSpec.describe "Likes", type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    driven_by(:rack_test)
    data = {
      '北海道' => ['札幌市', '札幌市中央区', '札幌市北区'],
      '青森県' => ['青森市', '弘前市']
    }
    create_area1_and_area2_from_seed(data)
  end

  describe "Like creation and cancellation" do
    before do
      log_in(user)
      visit new_restaurant_path
      fill_in 'restaurant-name', with: "xxxx"
      find("#prefectureSelect").find("option[value='1']").select_option
      click_button "お店を追加"
      @restaurant = Restaurant.last
    end

    it "creates a like and shows the restaurant name on likes page" do
      visit restaurant_path(@restaurant.id)
      click_on "♥"  # いいね作成
      visit likes_path(user)
      expect(page).to have_content("xxxx")
    end

    it "cancels an existing like and removes the restaurant name from likes page" do
      visit restaurant_path(@restaurant.id)
      click_on "♥"
      visit likes_path(user)
      expect(page).to have_content("xxxx")
      visit restaurant_path(@restaurant.id)
      click_on "♥"
      visit likes_path(user)
      expect(page).to_not have_content("xxxx")
    end
  end
end
