class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.references  :blog,                                null: false, index: true
      t.string      :name,      size: 64,                 null: false, index: true
      t.text        :value,                               null: false
      t.string      :autoload,  size: 20, default: 'yes', null: false
    end
  end
end
