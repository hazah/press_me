class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :post, index: true
      t.text :author
      t.string      :email,         size: 100
      t.string      :url,           size: 200
      t.string      :ip,            size: 100
      t.text        :content
      t.integer     :karma
      t.string      :approved,      size: 20
      t.string      :agent,         size: 255
      t.string      :comment_type,  size: 20
      t.integer     :parent
      t.references  :user,          index: true

      t.timestamps
    end
  end
end
