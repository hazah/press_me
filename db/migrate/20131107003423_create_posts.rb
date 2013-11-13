class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references  :blog,            null: false,                                  index: true
      t.references  :user,            null: false,                                  index: true
      t.text        :title,           null: false
      t.text        :content,         null: false
      t.text        :exerpt,          null: false
      t.string      :status,          size: 20,    default: 'publish', null: false
      t.string      :comment_status,  size: 20,    default: 'open',    null: false
      t.string      :ping_status,     size: 20,    default: 'open',    null: false
      t.string      :password_digest, size: 255,                       null: false
      t.string      :name,            size: 200,                       null: false
      t.text        :ping,                                             null: false
      t.text        :pinged,                                           null: false
      t.text        :filtered,                                         null: false
      t.integer     :parent,                                           null: false
      t.integer     :menu_order,                                       null: false
      t.string      :type,            size: 32,                        null: false
      t.string      :mime_type,       size: 100,                       null: false
      t.integer     :comment_count,                                    null: false

      t.timestamps
    end
  end
end
