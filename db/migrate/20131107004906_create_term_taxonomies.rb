class CreateTermTaxonomies < ActiveRecord::Migration
  def change
    create_table :term_taxonomies do |t|
      t.references  :term,      index: true
      t.string      :taxonomy,  size: 32
      t.text        :description
      t.references  :parent,    null: true
      t.integer     :count

      t.timestamps
    end
  end
end
