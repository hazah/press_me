class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :blog

  has_and_belongs_to_many :term_taxonomies

  # Must be included before any call to 'scope'
  include Authority::Abilities

  scope :published,   ->() { where(status: 'publish') } do
    def published?
      true
    end
  end

  scope :unpublished, ->() { where.not(status: 'publish') }

  scope :owned_by, ->(user) { where(user: user) } do
    def owned_by?(user)
      to_a.all? { |post| post.owned_by? user }
    end
  end

  # Scopes aren't concidered published by default, overridden in scope extensions.
  def self.published?
    false
  end

  def self.owned_by?(user)
    false
  end

  def published?
    self.status == 'publish'
  end

  def owned_by?(user)
    self.user == user
  end
end
