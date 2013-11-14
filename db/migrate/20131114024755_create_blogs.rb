class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.references :site,                                null: false, index: true
      t.string     :domain,   size: 200,                 null: false
      t.string     :path,     size: 100,                 null: false
      t.boolean    :public,              default: true,  null: false
      t.boolean    :archived,            default: false, null: false
      t.boolean    :mature,              default: false, null: false
      t.boolean    :span,                default: false, null: false
      t.boolean    :deleted,             default: false, null: false
      t.integer    :lang_id,             default: 0,     null: false, index: true

      t.timestamps null: false

      t.index [:domain, :path]
    end
  end
end
