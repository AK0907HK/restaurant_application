require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "#home" do
    it "returns_http_success" do
      get root_path
      expect(response).to have_http_status :ok
    end
  end

end
