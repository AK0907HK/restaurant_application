require 'rails_helper'

RSpec.describe "Restaurants", type: :system do
  let(:user) { FactoryBot.create(:user4) }

  before do
    driven_by(:rack_test)
    data = {
      '北海道' => ['札幌市', '札幌市中央区', '札幌市北区'],
      '青森県' => ['青森市', '弘前市'],
    }
    create_area1_and_area2_from_seed(data)
  end
 







  describe 'index' do
    before do
      FactoryBot.send(:user_with_restaurants, restaurants_count: 40)
      @user = Restaurant.first.user
      @user.password = 'user_password'
      log_in(@user)
      visit user_path @user
    end  

    it 'check exsist 30 restaurants data' do
      visit restaurants_path
      restaurant_wrapper = 
        within 'ol.restaurants' do
          find_all('li')  
        end  
      expect(restaurant_wrapper.size).to eq 30  
    end  

    it 'check exsist pagination selector' do
      visit restaurants_path
      expect(page).to have_selector 'div.pagination'
    end

    it 'check restauarnt data has content' do
      visit restaurants_path
      @user.restaurants.paginate(page:1).each do |restauarnt|
        expect(page).to have_content restauarnt.name
      end
    end
  end

  describe 'creare' do

    before do
      log_in(user)
      visit new_restaurant_path
    end 
    
    context 'case in valid data' do
      it 'check can add resturant' do
        fill_in 'restaurant-name',with:"xxxx"
        find("#prefectureSelect").find("option[value='1']").select_option
        click_button "お店を追加"
        redirect_to restaurants_path
      end  
    end

    context 'case in invalid data' do
      it 'check not add restaurant' do
        fill_in 'restaurant-name',with:""
        click_button "お店を追加"
        redirect_to new_restaurant_path
      end  
    end

  describe 'delete' do

      before do
        log_in(user)
      end 
 
      it 'check display post delete button' do
        visit new_restaurant_path
        fill_in 'restaurant-name',with:"xxxx"
        find("#prefectureSelect").find("option[value='1']").select_option
        #select "北海道", from: "restaurant[area1]"
        click_button "お店を追加"
        visit restaurants_path
        restaurant = Restaurant.first
        visit restaurant_path(restaurant)
        expect {click_link '削除', href: restaurant_path(restaurant)}.to change(Restaurant, :count).by -1
      end
    end
  end  

  describe 'edit' do
    
    before do
      log_in(user) 
    end

    context 'case in valid' do
      it 'check can update restaurant' do
        visit new_restaurant_path
        fill_in 'restaurant-name',with:"xxxx"
        find("#prefectureSelect").find("option[value='1']").select_option
        click_button "お店を追加"
        restaurant = Restaurant.first
        visit edit_restaurant_path(restaurant)
        fill_in 'restaurant-name',with:"yyyy"
        find("#prefectureSelect").find("option[value='1']").select_option
        click_button "お店情報を編集"
        redirect_to restaurants_path
      end  
    end  

    context 'case in invalid' do
      it 'check can update restaurant' do
        visit new_restaurant_path
        fill_in 'restaurant-name',with:"xxxx"
        find("#prefectureSelect").find("option[value='1']").select_option
        click_button "お店を追加"
        restaurant = Restaurant.first
        visit edit_restaurant_path(restaurant)
        fill_in 'restaurant-name',with:"  "
        find("#prefectureSelect").find("option[value='1']").select_option
        click_button "お店情報を編集"
        redirect_to edit_restaurant_path(restaurant)
      
      end  
    end  
  end  
end  