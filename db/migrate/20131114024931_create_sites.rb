class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :domain, size: 200, null: false
      t.string :path,   size: 100, null: false

      t.timestamps null: false

      t.index [:domain, :path]
    end
  end
end
