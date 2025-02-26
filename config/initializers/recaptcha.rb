Recaptcha.configure do |config|
  config.site_key = Rails.application.credentials.recaptcha_v2_site_key
  config.secret_key = Rails.application.credentials.recaptcha_v2_secret_key
end