class CreateMetadata < ActiveRecord::Migration
  def change
    create_table :metadata do |t|
      t.references :resource, polymorphic: true, index: true
      t.string :key, size: 255
      t.text :value

      t.timestamps
    end
  end
end
