class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references  :users,           index: true
      t.text        :title
      t.text        :content
      t.text        :exerpt
      t.string      :status,          size: 20
      t.string      :comment_status,  size: 20
      t.string      :ping_status,     size: 20
      t.string      :password_digest, size: 20
      t.string      :name,            size: 200
      t.text        :ping
      t.text        :pinged
      t.text        :filter
      t.integer     :parent
      t.integer     :menu_order
      t.string      :type,            size: 32
      t.string      :mime_type,       size: 100
      t.integer     :comment_count

      t.timestamps
    end
  end
end
