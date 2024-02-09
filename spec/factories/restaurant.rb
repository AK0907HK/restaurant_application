FactoryBot.define do
  factory :restaurant1, class: Restaurant do
    name { 'xxxx' }
    area1 { 1 }
  end
   
  factory :restaurant2, class: Restaurant do
    name { 'yyyy' }
    area1 { 2 }
    user { association :user, email: 'restaurant@example.com' }
  end
end  

def user_with_restaurants(restaurants_count: 5)
  FactoryBot.create(:user) do |user|
    FactoryBot.create_list(:restaurant1, restaurants_count, user: user)
  end
end 


  