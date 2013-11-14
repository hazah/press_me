class CreateTermTaxonomies < ActiveRecord::Migration
  def change
    create_table :term_taxonomies do |t|
      t.references  :term,                              null: false, index: true
      t.string      :taxonomy,    size: 32,             null: false, index: true
      t.text        :description,                       null: false
      t.references  :parent
      t.integer     :count,                 default: 0, null: false

      t.timestamps null: false

      t.index [:term_id, :taxonomy]
    end
  end
end
