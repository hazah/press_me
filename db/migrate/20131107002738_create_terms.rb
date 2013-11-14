class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.references  :blog,                         null: false, index: true
      t.string      :name,  size: 200,             null: false, index: true
      t.string      :slug,  size: 200,             null: false, unique: true
      t.integer     :group,            default: 0, null: false

      t.timestamps null: false
    end
  end
end
