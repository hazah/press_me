class User < ActiveRecord::Base
  scope :global,    ->() { where{ id == PressMe.anonymous } }
  scope :developer, ->() { where{ id == PressMe.developer } }

  has_many :posts
  has_many :comments

  has_many :metadata, as: :resource

  has_secure_password

  validates :email, :password,  presence: true,     unless: ->(u) { u.id == 0 || u.is_a?(Developer) }
  validates :password,          confirmation: true, unless: ->(u) { u.password.blank? }

  include Authority::UserAbilities

  def roles
    @roles ||= begin
      metadata.find_by(key: 'roles').value.keys.flatten
    end
  end

  def permissions
    @permissions ||= begin
      metadata.find_by(key: 'roles').value.values.flatten
    end
  end
end
