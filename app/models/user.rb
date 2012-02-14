class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  has_many :charges
  has_many :uploads, :through => :charges
  
   attr_accessible :email, :password, :password_confirmation, :username, :stripe_customer_token
   
   validates_confirmation_of   :password
   validates_presence_of       :password, :on => :create
   validates_uniqueness_of     :username
   validates_format_of         :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
   
   validates :email, :uniqueness => { :case_sensitive => false },
                     :presence => true
                     
   validates :username,  :uniqueness => { :case_sensitive => false },
                     :presence => true
  
end
