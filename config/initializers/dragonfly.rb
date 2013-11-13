require 'dragonfly'

Dragonfly[:file_upload].tap do |app|
  app.configure_with(:rails)
  app.configure_with(:imagemagick)

  app.cache_duration = 3600 * 24 * 365 * 3

  app.define_macro(ActiveRecord::Base, :file_accessor)
  app.define_macro(ActiveRecord::Base, :image_accessor)
end
