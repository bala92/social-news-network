class User < ActiveRecord::Base
  
    #attr_accessible :name
  
    has_many :authorizations
    validates :name, :email, :presence => true
    
    def self.create_user! (hash)
      session = SecureRandom.base64
      hash[:session_token]= session
      User.create!(hash)
    end
    
    def add_provider(auth_hash)
      # Check if the provider already exists, so we don't add it twice
      unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
        Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
      end
    end
end
