require 'rails_helper'

RSpec.describe Restaurant, type: :model do

  before(:all) do
    ActiveRecord::Base.connection
  end
  
  let(:user) { FactoryBot.create(:user) }
  #let(:restaurant) { Restaurant.new(name: 'xxxx', area1:1,user_id: user.id) }
  let(:restaurant) { user.restaurants.build(name: 'xxxx', area1:1) }
  
  it 'check data is valid' do
    expect(restaurant).to be_valid
  end  

  it 'if user is null then data is invalid' do
    restaurant.user_id = nil
    expect(restaurant).to_not be_valid
  end  
  
  describe 'content' do
    it 'if there are null  then data is ivalide' do
      restaurant.name = ' '
      restaurant.area1 = ' '
      expect(restaurant).to_not be_valid
    end

    it 'check coment word size' do
      restaurant.coment = 'a' * 301
      expect(restaurant).to_not be_valid
    end  

  end  
end
 