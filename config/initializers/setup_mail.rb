ActionMailer::Base.smtp_settings = {
        :address                => "host282.hostmonster.com",
        :port                   => 26,
        :domain                 => "dead-body-flashers.com",
        :user_name              => ENV['SMTP_USER'],
        :password               => ENV['SMTP_PASS'],
        :authentication         => "plain",
        :enable_starttls_auto   => false
}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"

