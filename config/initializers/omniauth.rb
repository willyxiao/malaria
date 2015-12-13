OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  # provicer :facebook, app id, app secret (both found on developers.facebook.com)
  provider  :facebook, "1520222368275265", "ead1701c1bf888bc89ce26106428b8d5",
            # what we decide to collect from Facebook users
            :scope => "email,public_profile,user_friends",
            # specify SSL client certificate
            :client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}
end