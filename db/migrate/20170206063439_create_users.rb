class CreateUsers < ActiveRecord::Migration[5.0]
  # changeメソッドは、migrateを実行した時の処理を定義します。
  # http://tanihiro.hatenablog.com/entry/2014/01/10/182122
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
