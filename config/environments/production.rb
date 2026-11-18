Rottenpotatoes::Application.configure do
  config.cache_classes = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.eager_load = true
  config.public_file_server.enabled = true
  config.assets.compile = true
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_level = :info
end
