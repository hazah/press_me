class Metadatum < ActiveRecord::Base
  belongs_to :resource, polymorphic: true

  serialize :value
end
