FactoryBot.define do
    factory :area1 do
      sequence(:name) { |n| "Prefecture #{n}" }
    end
  end
  