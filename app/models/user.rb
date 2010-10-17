class User 
  include MongoMapper::Document
  
  key :name, String
  key :provider, String
  
  many :authorizations
  validates_uniqueness_of :name, :scope => :provider, :message => "must be unique"
  
  def self.create_from_hash!(hash)
    create(:name => hash['user_info']['name'] || hash['user_info'][:name], :provider => hash['provider'])
  end
end
