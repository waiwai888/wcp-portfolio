class PostTag < ApplicationRecord
  
  belongs_to :post
  belongs_to :tag
  
  # 2つの外部キーが存在することは必須であるためバリデーションを設定
  validates :post_id, presence: true
  validates :tag_id, presence: true

end
