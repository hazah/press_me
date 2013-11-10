class Post < ActiveRecord::Base
  belongs_to :user

  has_and_belongs_to_many :term_taxonomies

  include Authority::Abilities
end
