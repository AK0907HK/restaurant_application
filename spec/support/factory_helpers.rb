module FactoryHelpers
    def create_area1_and_area2_from_seed(data)
      data.each_with_index do |(prefecture_name, city_names), index|
        area1 = FactoryBot.create(:area1, id: index + 1, name: prefecture_name)
        city_names.each do |city_name|
          FactoryBot.create(:area2, city: city_name, area1: area1)
        end
      end
    end
  end
  
  RSpec.configure do |config|
    config.include FactoryHelpers
  end
  