class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :blog

  has_and_belongs_to_many :term_taxonomies

  include Authority::Abilities

  scope :published,   ->() { where(status: 'publish') } do
    def authorizer
      PostAuthorizer::Published
    end

    include Authority::Abilities::Definitions
  end

  scope :unpublished, ->() { where.not(status: 'publish') } do
    def authorizer
    puts "HERE"
      PostAuthorizer::Unpublished
    end

    include Authority::Abilities::Definitions
  end
end
