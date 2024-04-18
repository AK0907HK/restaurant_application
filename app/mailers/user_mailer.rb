class UserMailer < ApplicationMailer 

  #メールアドレスの有効化
  def account_activation(user)
    @user = user
    mail to: user.email , subject: "【ResturantChooser】メールアドレスの確認"
  end
  
  #パスワードの変更
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "パスワード変更"
  end
end
