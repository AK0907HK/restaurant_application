require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user){FactoryBot.create(:user)}

  describe "account_activation" do
    let(:user) {FactoryBot.create(:user)}
    let(:mail) { UserMailer.account_activation(user) }

    before do
      user.activation_token = User.new_token
    end

    it 'check mail subject' do
     expect(mail.subject).to eq("【ResturantChooser】メールアドレスの確認")
    end  

    it 'check mail sender' do
     expect(mail.from).to eq(["account_activation@restaurantchooser.com"])
    end  

    it 'check mail activation_token' do
      expect(mail.body.encoded).to match(user.activation_token)
    end  

    it 'メール本文にユーザのemailが表示されていること' do
      expect(mail.body.encoded).to match(CGI.escape(user.email))
    end
  end

  describe "password_reset" do
    let(:mail) { UserMailer.password_reset(user) }

    before do
      user.reset_token = User.new_token
    end  

    it 'check  mail subject' do
      expect(mail.subject).to eq('パスワード変更')
    end

    it 'check mail sender' do
      expect(mail.from).to eq(["account_activation@restaurantchooser.com"])
    end  
 

    #it "renders the headers" do
      #expect(mail.subject).to eq("Password reset")
      #expect(mail.to).to eq(["to@example.org"])
      #expect(mail.from).to eq(["from@example.com"])
    #end

    #it "renders the body" do
      #expect(mail.body.encoded).to match("Hi")
    #end
  #end
  end
end
