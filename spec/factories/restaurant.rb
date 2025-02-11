FactoryBot.define do
  factory :restaurant1, class: Restaurant do
    name { 'xxxx' }
    association :area1
  end
   
  factory :restaurant2, class: Restaurant do
    name { 'yyyy' }
    user { association :user, email: 'restaurant@example.com' }
    association :area1
  end

  factory :restaurant3, class: Restaurant do
    name { 'zzzz' }
    user { association :user, email: 'restaurant2@example.com' }
    association :area1
  end
end  

def user_with_restaurants(restaurants_count: 5)
  FactoryBot.create(:user) do |user|
    FactoryBot.create_list(:restaurant1, restaurants_count, user: user)
  end
end 

def user2_with_restaurants(restaurants_count: 5)
  FactoryBot.create(:user) do |user2|
    FactoryBot.create_list(:restaurant2, restaurants_count, user: user2)
  end
end

def user2_with_restaurants(restaurants_count: 5)
  FactoryBot.create(:user) do |user3|
    FactoryBot.create_list(:restaurant3, restaurants_count, user: user3)
  end
end

  