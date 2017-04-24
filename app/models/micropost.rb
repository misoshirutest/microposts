class Micropost < ApplicationRecord
  belongs_to :user
  # これは、User と Micropost の一対多を表現しています。このコードのおかげで、micropost.user とすると、この micropost インスタンスを持っている User を取得することができます。
 # https://railsguides.jp/association_basics.html#belongs-to%E9%96%A2%E9%80%A3%E4%BB%98%E3%81%91


  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
end
