class Post < ApplicationRecord
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many_attached :images 
  #do |attachable|
    #attachable.variant :display, resize_to_limit: [500, 500]
  #end
  default_scope -> {order(created_at: :desc)}
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum:300}
  validates :name, presence:true,length: {maximum:50}
  validates :images,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "対応している画像形式ではありません" },
                      size:         { less_than: 5.megabytes,
                                      message:   "5MBより大きいファイルを投稿できません" }
  validate :image_length

 
  
  
  #検索用                                   
  def self.search_for(content)
    Post.where(['content Like(?) OR name Like(?)',"%#{content}%","%#{content}%"])
  end  

  private 


def image_length
    if images.length > 4
      images.purge
      errors.add(:images, "は4枚以内にしてください")
    end
  end
end
 