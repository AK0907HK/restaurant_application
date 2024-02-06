require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user){ User.new(name: 'ユーザー', email: 'user@restaurantchooser.com',password: 'password',password_confirmation:  'password' ) }
  let(:user2){ User.new(name: 'ユーザー', email: 'user@restaurantchooser.com',password: 'password',password_confirmation:  'password' ) }


  it 'valid user name' do
    expect(user).to be_valid
  end  

  it 'not valid user name' do
    user.name = ' '
    expect(user).to_not be_valid
  end  
  
  it 'not valide user email' do
    user.email = ' '
    expect(user).to_not be_valid
  end  

  it 'user name length not too long' do
    user.name = 'x' * 31
    expect(user).to_not be_valid
  end  

  it 'user email length not too long' do
    user.email = "#{'x' * 235}@restaurantchooser.com"
    expect(user).to_not be_valid
  end  

  it 'check right email format' do
    valid_addresses = %w[user@exmple.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      user.email = valid_address
      expect(user).to be_valid
    end  
  end

  it 'check wrong email format' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      user.email = invalid_address
      expect(user).to_not be_valid
    end
  end

  it 'not enroll same acoount twice' do
    user.save
    expect(user2).to_not be_valid
  end  

  it 'must fill password' do
    user.password = user.password_confirmation = ' ' * 8
    expect(user).to_not be_valid
  end 

  it 'password must have more than 6 words' do
    user.password = user.password_confirmation = 'x' * 5
    expect(user).to_not be_valid
  end  
end

