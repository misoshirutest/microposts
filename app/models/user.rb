class User < ApplicationRecord
  # User インスタンス（レコード）を保存するその前に、実行。すべて小文字に
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    # メールアドレス判定
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    # case_sensitive: false  大文字と小文字を区別しない
                    uniqueness: { case_sensitive: false }
  has_secure_password

  has_many :microposts
  # https://railsguides.jp/association_basics.html#has-many%E9%96%A2%E9%80%A3%E4%BB%98%E3%81%91

  # 理解度低め。
  # https://techacademy.jp/my/rails/twitter-clone#chapter-10-1
  # https://railsguides.jp/association_basics.html
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
end
