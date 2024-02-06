require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "helper test" do    
    let(:user){ FactoryBot.create(:user)}
    before do
      remember(user)
    end
    
    context "session is blank" do
      it '2 users information are right' do
        expect(user).to eq current_user
        expect(logged_in?).to be_truthy
      end
    end    

    context "remember digest is wrong" do
        it "returns nil" do
          user.update_attribute(:remember_digest, User.digest(User.new_token))
          expect(current_user).to be_nil
        end
    end
 end
end      

