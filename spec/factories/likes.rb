# spec/factories/likes.rb
FactoryBot.define do
    factory :like do
      association :user
      association :restaurant
    end
  end
  