class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :name, size: 200
      t.string :slug, size: 200
      t.integer :group

      t.timestamps
    end
  end
end
