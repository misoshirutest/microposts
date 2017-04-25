class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.references :user, foreign_key: true
      t.references :follow, foreign_key: { to_table: :users }
      # 外部キーとして参照すべきテーブルを指定しています。指定しないと、Rails のデフォルトの命名規則により、 follows テーブルを参照してしまいます。しかし、follows テーブルは存在しないのでエラーとなってしまいます。今回の修正によって、外部キーは follow でありながら、参照先のテーブルは users とすることが可能になります。

      t.timestamps
      
      t.index [:user_id, :follow_id], unique: true
      # user_id と follow_id のペアで重複するものが保存されないようにするデータベースの設定です。あるユーザがあるユーザをフォローしたとき、フォローを解除せずに、重複して何度もフォローできてしまうような事態を防いでいるだけです。
    end
  end
end
