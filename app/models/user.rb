class User < ActiveRecord::Base
  scope :global,    ->() { where{ id == PressMe.anonymous } }
  scope :developer, ->() { where{ id == PressMe.developer } }

  has_many :posts
  has_many :comments

  has_eav through: :metadatum, as: :resource do
    eav_attribute :first_name
    eav_attribute :last_name
    eav_attribute :description
    eav_attribute :roles
  end

  has_secure_password

  validates :email, :password,  presence: true,     unless: ->(u) { u.id == 0 || u.is_a?(Developer) }
  validates :password,          confirmation: true, unless: ->(u) { u.password.blank? }

  include Authority::UserAbilities
end
