Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/0' , password: 'f7d8279ad6ecaea58ccffd277a79b1cc4019da22713118805a9341d15a76c178'}
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/0' , password: 'f7d8279ad6ecaea58ccffd277a79b1cc4019da22713118805a9341d15a76c178'}
end
