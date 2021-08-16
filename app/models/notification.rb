class Notification < ApplicationRecord
  
  # 並び順を作成日時の降順に指定
  default_scope -> { order(created_at: :desc) }
  # 今回、必要なid以外はnilを格納するよう指定するため、optional: trueを付与
  belongs_to :post, optional: true
  # belongs_to :post_comment, optional: true
  
  belongs_to :visiter, class_name: 'User', foreign_key: 'visiter_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
  
  belongs_to :room, optional: true
  belongs_to :chat, optional: true
  
end
