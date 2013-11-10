class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.integer :blog_id
      t.string  :name,      size: 64
      t.text    :value
      t.string  :autoload,  size: 20
    end
  end
end
