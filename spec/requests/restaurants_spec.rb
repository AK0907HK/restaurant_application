require 'rails_helper'

RSpec.describe "Restaurants", type: :request do
  describe "create" do
    context 'case in not login' do
      it 'check can not add restaurant' do
        expect { post restaurants_path, params: { restaurant: { name: 'xxxx', area1: 1 } } }
          .to_not change(Restaurant, :count)
      end

      it 'check redirect to login page' do
        post restaurants_path, params: { restaurant: { name: 'xxxx', area1: 1 } }
        expect(response).to redirect_to login_path
      end
    end

    context 'case in login' do
      let(:user) { FactoryBot.create(:user) }

      before do
        log_in(user)
      end

      it 'can add restaurant with valid parameters' do
        expect {
          post restaurants_path, params: { restaurant: { name: 'valid restaurant', area1: 1 } }
        }.to change(Restaurant, :count).by(1)
      end

      it 'stays on new page when invalid parameters are submitted' do
        post restaurants_path, params: { restaurant: { name: '', area1: '' } }
        expect(response).to render_template(:new)
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
        expect { delete restaurant_path(@restaurant) }.to_not change(Restaurant, :count)
      end
    end

    context 'case in not login' do
      it 'check can not delete restaurant' do
        expect { delete restaurant_path(@restaurant) }.to_not change(Restaurant, :count)
      end

      it 'check redirect to login page' do
        delete restaurant_path(@restaurant)
        expect(response).to redirect_to login_path
      end
    end
  end

  describe '#edit' do
    context 'case in not login' do
      let(:restaurant) { FactoryBot.create(:restaurant2) }

      it 'redirects to login page' do
        get edit_restaurant_path(restaurant)
        expect(response).to redirect_to login_path
      end
    end

    context 'case in login' do
      let(:user) { FactoryBot.create(:user) }
      let!(:data) do
        {
          '北海道' => ['札幌市', '札幌市中央区', '札幌市北区'],
          '青森県' => ['青森市', '弘前市']
        }
      end
      let!(:restaurant) { FactoryBot.create(:restaurant2, user: user) }

      before do
        log_in(user)
        create_area1_and_area2_from_seed(data)
      end

      it 'updates restaurant with valid parameters without changing count' do
        expect {
          patch restaurant_path(restaurant), params: { restaurant: { name: 'edit', area1: '2' } }
        }.to_not change(Restaurant, :count)
        expect(response).to redirect_to restaurant_path(restaurant)
        restaurant.reload
        expect(restaurant.name).to eq('edit')
        expect(restaurant.area1.to_s).to eq('2')
      end

      it 'does not update restaurant with invalid parameters and re-renders edit page' do
        patch restaurant_path(restaurant), params: { restaurant: { name: '', area1: '' } }
        expect(response).to render_template(:edit)
        restaurant.reload
        expect(restaurant.name).to_not eq('')
      end
    end
  end
end
