class CreateMetadata < ActiveRecord::Migration
  def change
    create_table :metadata do |t|
      t.references  :resource, polymorphic: true, null: false, index: true
      t.string      :key,      size: 255,         null: false, index: true

      # Serialized
      t.text        :value
    end
  end
end
