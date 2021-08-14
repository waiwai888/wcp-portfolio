class Tag < ApplicationRecord

  has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :posts, through: :post_tags
  # post_tags（中間テーブル）との関連づけ。foreign_keyにtag_id（tag.idを入れて）を指定し、postを抽出


end
