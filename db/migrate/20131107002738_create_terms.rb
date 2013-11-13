class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.references  :blog,                         null: false, index: true
      t.string      :name,  size: 200,             null: false
      t.string      :slug,  size: 200,             null: false
      t.integer     :group,            default: 0, null: false

      t.timestamps
    end
  end
end
