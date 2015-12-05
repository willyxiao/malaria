OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider  :facebook, "1520222368275265", ENV['FACEBOOK_APP_SECRET'],
            :scope => "email,public_profile,user_friends",
            :client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}
end