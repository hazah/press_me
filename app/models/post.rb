class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :blog

  has_and_belongs_to_many :term_taxonomies
  include Slugalicious

  #slugged :title, scope: ->() {}

  scope :published,   ->() { where {status == 'publish'} } do
    def published?
      true
    end
  end

  scope :unpublished, ->() { where {status != 'publish'} }

  scope :owned_by, ->(owner) { where {user == my{owner}} } do
    def owned_by?(user)
      to_a.any? ? to_a.all? { |post| post.owned_by? user } : false
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
