require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'qPevdMdMBNtVqBXFqMQNrA', 'z8uKwkAwk9AbxO0PtAzh32HiYGTNmyzL5zzPIhB5T5s'
  provider :facebook, '126135840774560', 'fa431878c20eb6cf47b928e314fc66c9'
  provider :linked_in, 'aqX18lZjmscC06Ziqf27V-OpgBowpvjG7gJuFsKDxSgxIpe5P593K8CpwM-y0ppE', 'UOw51b0WO-mGgMY8fHNGoPtU9lkZtlU0v3QE2EribegeaIBdRUZXOxnB12AefAeF'
end