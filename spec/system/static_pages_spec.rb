require 'rails_helper'
 
RSpec.describe "StaticPages", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'root' do
    it 'root_path_are_exits_two_rinks' do
      visit root_path
    expect(page.find_all("a[href=\"#{root_path}\"]").length).to eq 2
           #page.find_all("a[href=\"#{root_path}\"]")
    end
  end
end    