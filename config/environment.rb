# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  address: 'smtp.gmail.com',
  port: 587,
  domain: 'gmail.com',
  user_name: 'joejviewingparty@gmail.com',
  password: ENV['google_password'],
  authentication: 'plain',
  enable_starttls_auto: true
}
