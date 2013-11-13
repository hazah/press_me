class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.references  :blog,                                  null: false, index: true
      t.string      :url,          size: 255,               null: false
      t.string      :name,         size: 255,               null: false
      t.string      :image_uid,    size: 255,               null: false
      t.string      :image_name,   size: 255,               null: false
      t.string      :image_ext,    size: 255,               null: false
      t.string      :image_size,   size: 255,               null: false
      t.string      :image_width,  size: 255,               null: false
      t.string      :image_height, size: 255,               null: false
      t.string      :image_depth,  size: 255,               null: false
      t.string      :image_format, size: 25,                null: false
      t.string      :target,       size: 255,               null: false
      t.string      :description,  size: 255,               null: false
      t.boolean     :visible,                 default: true null: false
      t.integer     :owner,                   default: 1,   null: false
      t.integer     :rating,                  default: 1,   null: false
      t.string      :rel,          size: 255,               null: false
      t.text        :notes,        size: 255,               null: false
      t.string      :rss,          size: 255,               null: false

      t.timestamps
    end
  end
end
