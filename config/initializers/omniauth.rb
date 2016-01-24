OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider  :facebook, ENV["FACEBOOK_APP_ID"], ENV['FACEBOOK_APP_SECRET'],
            :scope => "email,public_profile,user_friends",
            :display => 'page',
            :client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}
            # TODO set callback_uri because https isn't appended correclty
            # :callback_uri => 'https://'
end
