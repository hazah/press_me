class TermTaxonomy < ActiveRecord::Base
  belongs_to :term

  has_and_belongs_to_many :posts
end
