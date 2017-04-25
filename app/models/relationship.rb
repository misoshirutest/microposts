class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User'
  # 自分で書き換える必要あり。class_name: 'User' と補足設定することで、follow が Follow という存在しないクラスを参照することを防ぎ、User クラスであることを明示しています。

  validates :user_id, presence: true
  validates :follow_id, presence: true
end
