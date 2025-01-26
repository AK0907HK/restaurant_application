FactoryBot.define do
    factory :area2 do
      sequence(:city) { |n| "City #{n}" }
      association :area1
    end
  end
  