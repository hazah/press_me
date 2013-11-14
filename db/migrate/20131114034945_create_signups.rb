class CreateSignups < ActiveRecord::Migration
  def change
    create_table :signups do |t|
      t.string   :domain,         size: 200,                null: false
      t.string   :path,           size: 100,                null: false
      t.text     :title,                                    null: false
      t.string   :email,          size: 60,                 null: false, index: true
      t.datetime :activated,                                null: false
      t.boolean  :active,                   default: false, null: false
      t.string   :activation_key, size: 50,                 null: false, index: true
      t.text     :meta

      t.timestamps null: false

      t.index [:domain, :path]
    end
  end
end
