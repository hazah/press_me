require 'dragonfly'

Dragonfly[:file_upload].tap do |app|
  app.configure_with(:rails)
  app.configure_with(:imagemagick)

  app.cache_duration = 3600 * 24 * 365 * 3

  app.define_macro(ActiveRecord::Base, :file_accessor)
  app.define_macro(ActiveRecord::Base, :image_accessor)

  app.configure do |config|
    config.server.before_serve do |job, env|
      if Rails.cache.exist? job.serialize
        if job.uid
          Rails.cache.delete job.serialize
        end
      else
        unless job.uid
          Rails.cache.write job.serialize, job.temp_object.data
        end
      end
    end
  end
end
