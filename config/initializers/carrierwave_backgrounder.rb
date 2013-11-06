CarrierWave::Backgrounder.configure do |config|
  config.backend :delayed_job, queue: :carrierwave
  # config.backend :resque, queue: :carrierwave
  # config.backend :sidekiq, queue: :carrierwave
  # config.backend :girl_friday, queue: :carrierwave
  # config.backend :sucker_punch, queue: :carrierwave
  # config.backend :qu, queue: :carrierwave
  # config.backend :qc
end
