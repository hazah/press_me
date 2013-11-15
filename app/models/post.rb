class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :blog

  has_and_belongs_to_many :term_taxonomies

  include Authority::Abilities

  scope :published,   ->() { where(status: 'publish') } do
    def self.authorizer
      PostAuthorizer.new(self)
    end

    def self.published?
      true
    end
  end

  scope :unpublished, ->() { where.not(status: 'publish') }

  def self.published?
    false
  end
end
