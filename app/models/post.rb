class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :blog

  has_and_belongs_to_many :term_taxonomies

  include Authority::Abilities

  def self.scope name, body, &block
    authorizer = self.authorizer.dup
    super.tap do |definition|
      singleton_class.send(:define_method, name) do |*args|
        definition.call(*args).tap do |scope|
          authorizer.scope = scope
        end
      end
    end
  end

  scope :published,   ->() { where(status: 'publish') } do
    def published?
      true
    end
  end

  scope :unpublished, ->() { where.not(status: 'publish') }

  def self.published?
    false
  end

  def published?
    self.status == 'publish'
  end
end
