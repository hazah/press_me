class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references  :blog,                                  null: false, index: true
      t.text        :author_name
      t.string      :author_email, size: 100
      t.string      :author_url,   size: 200
      t.string      :author_ip,    size: 100
      t.text        :content                                null: false
      t.integer     :karma,                   default: 0,   null: false
      t.string      :approved,     size: 20,  default: '1', null: false, index: true
      t.string      :agent,        size: 255,               null: false
      t.string      :comment_type, size: 20                 null: false
      t.references  :parent,                                             index: true
      t.references  :user,                                               index: true

      t.timestamps
    end
  end
end
