class Term < ActiveRecord::Base
  belongs_to :blog
  has_one :term_taxonomy
end
