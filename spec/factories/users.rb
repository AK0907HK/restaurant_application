FactoryBot.define do
  factory :user, class: User do
    #id {1}
    name { "mainuser" }
    email { "mainuser@restaurantchooser.com" }
    password { "user_password" }
    password_confirmation { "user_password" }
    activated {true}
    activated_at  {Time.zone.now}
  end

  factory :user2, class: User do
    name { "mainuser2" }
    email { "mainuser2@restaurantchooser.com" }
    password { "user2_password" }
    password_confirmation { "user2_password" }
    activated {true}
    activated_at  {Time.zone.now}
  end

  factory :user3, class: User do
    name { "activation_user" }
    email { "aoto.s19970907o@gmail.com" }
    password { "activation_password" }
    password_confirmation { "activation_password" }
    activated {true}
    activated_at  {Time.zone.now}
  end  

  
  factory :user4, class: User do
    
    name { "restaurant_user" }
    email { "resturant@restaurantchooser.com" }
    password { "restaurant_password" }
    password_confirmation { "restaurant_password" }
    activated {true}
    activated_at  {Time.zone.now}
  end  


end
