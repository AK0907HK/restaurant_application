class Restaurant < ApplicationRecord
  belongs_to :user 
  #has_one_attached :image
  has_many_attached :images 
  #has_many: posts
  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true
  #validates :user_r_id, presence: true
  validates :area1, presence: true
  validates :coment, length: { maximum: 300}

#validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
#  message: "対応している画像形式ではありません" },
#size:         { less_than: 5.megabytes,
#  message:   "5MBより大きいファイルを投稿できません" }

  validates :images,   content_type: { in: %w[image/jpeg image/gif image/png],
  message: "対応している画像形式ではありません" },
  size:         { less_than: 5.megabytes,
  message:   "5MBより大きいファイルを投稿できません" }
  validate :image_length

  def self.search_for(area1,area2,timing,genre)
    Restaurant.where(['area1 Like(?) AND area2 Like(?) AND timing Like(?) AND genre Like(?)',"%#{area1}%","%#{area2}%","%#{timing}%","%#{genre}%"])
  end  

  def self.choose_for(area1,area2,timing,genre,user)
    Restaurant.where(['area1 Like(?) AND area2 Like(?) AND timing Like(?) AND genre Like(?) AND user_id =?',"%#{area1}%","%#{area2}%","%#{timing}%","%#{genre}%",user])
  end 

  def image_length
    if images.length > 4
      images.purge
      errors.add(:images, "は4枚以内にしてください")
    end
  end
end 