class Restaurant < ApplicationRecord
  belongs_to :user 
  has_one_attached :image
  #has_many: posts
  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true
  #validates :user_r_id, presence: true
  validates :area1, presence: true
  #validates :area2, presence: true
  #validates :type
  #validates :time
  validates :coment, length: { maximum: 100}
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
  message: "対応している画像形式ではありません" },
size:         { less_than: 5.megabytes,
  message:   "5MBより大きいファイルを投稿できません" }

  def self.search_for(area1,area2,time,genre)
    Restaurant.where(['area1 Like(?) AND area2 Like(?) AND time Like(?) AND genre Like(?)',"%#{area1}%","%#{area2}%","%#{time}%","%#{genre}%"])
  end  

  def self.choose_for(area1,area2,time,genre,user)
    Restaurant.where(['area1 Like(?) AND area2 Like(?) AND time Like(?) AND genre Like(?) AND user_id =?',"%#{area1}%","%#{area2}%","%#{time}%","%#{genre}%",user])
  end 
end