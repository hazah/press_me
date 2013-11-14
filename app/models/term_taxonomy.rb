class TermTaxonomy < ActiveRecord::Base
  belongs_to :term
  belongs_to :parent, class_name: :term_taxonomy

  has_and_belongs_to_many :posts
end
