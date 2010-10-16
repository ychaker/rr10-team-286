class Vote
  include MongoMapper::Document

  key :name, String, :required => true 
  key :version, String, :required => true 
  key :user_id, ObjectId, :required => true 
  key :timestamp, Time, :required => true 

  belongs_to :user
  validates_uniqueness_of :user_id, :scope => :name, :message => "gets only one vote per gem!"

  scope :by_user,  proc {|user_id| where(:user_id => user_id) }
  scope :by_name,  proc {|name| where(:name => name) }
  scope :my_votes, proc {|user_id| where(:user_id => name) }

  def mine?(user_id)
    user_id == self.user_id
  end

  def self.deprecated?(name)
    Vote.by_name(name).count >= 5
  end

  def self.recent
    Vote.all(:order => 'timestamp DEC', :limit => 15)
  end
end
