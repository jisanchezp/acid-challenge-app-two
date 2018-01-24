# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  user_name: Figaro.env.SENDGRID_USERNAME,
  password: Figaro.env.SENDGRID_PASSWORD,
  domain: Figaro.env.smtp_domain,
  address: "smtp.sendgrid.net",
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}
