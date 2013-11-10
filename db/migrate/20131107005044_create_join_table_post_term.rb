class CreateJoinTablePostTerm < ActiveRecord::Migration
  def change
    create_join_table :posts, :term_taxonomies do |t|
      t.index [:post_id, :term_taxonomy_id]
      t.index [:term_taxonomy_id, :post_id]
    end
  end
end
