class User < ApplicationRecord
  has_one_attached :image
  has_many :posts, dependent: :destroy
  has_many :restaurants, dependent: :destroy
  has_many :likes, dependent: :destroy
  attr_accessor :remember_token,:activation_token, :reset_token
  before_save :downcase_email
  #before_create :create_activation_digest
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 8}, allow_nil: true
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
  message: "対応している画像形式ではありません" },
size:         { less_than: 5.megabytes,
  message:   "5MBより大きいファイルを投稿できません" }

  # ハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end  


  #有効化トークンの確認
  def authenticated?(attribute,token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end  



  #アカウントの有効化
  def activate
    update_attribute(:activated,true)
    update_attribute(:activated_at,Time.zone.now)
  end

  #有効化のためのメールを送る
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end 

  # パスワード再設定の属性を設定する
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end
  
  #パスワード変更のためのメールを送る
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # パスワード再設定の期限が切れている場合はtrueを返す
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  
  private
    #emailをすべて小文字化
    def downcase_email
      self.email = email.downcase
    end  


end