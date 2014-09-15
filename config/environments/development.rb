CustomRepairs::Application.configure do
#config.action_mailer.delivery_method = :smtp
config.action_mailer.delivery_method = :letter_opener
config.action_mailer.smtp_settings = {
	        :address                => "host282.hostmonster.com",
	        :port                   => 26,
	        :domain                 => "dead-body-flashers.com",
	        :user_name              => ENV['SMTP_USER'],
	        :password               => ENV['SMTP_PASS'],
	        :authentication         => "plain",
        :enable_starttls_auto   => false
}

  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  config.cache_classes = false

  config.eager_load = false

  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  config.action_mailer.raise_delivery_errors = true

  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
end
