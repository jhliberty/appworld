require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = { 
      :username => "exampleuser", 
      :email => "example@user.com", 
      :password => "password",
      :password_confirmation => "password"
      }
  end
  
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  describe "validations" do
    
    it "should require a username" do
      no_username = User.new(@attr.merge(:username => ""))
      no_username.should_not be_valid
    end
    
    it "should require an email address" do
      no_email = User.new(@attr.merge(:email => ""))
      no_email.should_not be_valid
    end
  
    it "should require a matching password confirmation" do
      mismatch_confirmation = User.new(@attr.merge(:password_confirmation => "banana"))
      mismatch_confirmation.should_not be_valid
    end
    
    it "should accept valid email addresses" do
      addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      addresses.each do |address|
        valid_email_user = User.new(@attr.merge(:email => address))
        valid_email_user.should be_valid
      end
    end

    it "should reject invalid email addresses" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |address|
        invalid_email_user = User.new(@attr.merge(:email => address))
        invalid_email_user.should_not be_valid
      end
    end
    
    it "should reject email addresses identical up to case" do
      upcased_email = @attr[:email].upcase
      User.create!(@attr.merge(:email => upcased_email))
      user_with_duplicate_email = User.new(@attr)
      user_with_duplicate_email.should_not be_valid
    end
  end
end
