require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'qPevdMdMBNtVqBXFqMQNrA', 'z8uKwkAwk9AbxO0PtAzh32HiYGTNmyzL5zzPIhB5T5s'
  provider :open_id, OpenID::Store::Filesystem.new('/tmp')
  provider :google_apps, OpenID::Store::Filesystem.new('/tmp')
  # provider :facebook, 'APP_ID', 'APP_SECRET'
  # provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end