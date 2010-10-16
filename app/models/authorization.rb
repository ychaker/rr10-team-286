class Authorization 
  include MongoMapper::Document
  
  key :provider, String, :required => true
  key :uid, String , :required => true
  key :user_id, ObjectId, :required => true
  
  belongs_to :user
  validates_uniqueness_of :uid, :scope => :provider
  
  def self.find_from_hash(hash)
    find_by_provider_and_uid(hash['provider'], hash['uid'])
  end

  def self.create_from_hash(hash, user = nil)
    user ||= User.create_from_hash!(hash)
    Authorization.create(:user_id => user.id, :uid => hash['uid'], :provider => hash['provider'])
  end
end
