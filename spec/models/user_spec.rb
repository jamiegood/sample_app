# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe User do
  
  before { @user = User.new(name: "Example User", email: "user@example.com")}
  
  subject { @user }
  
  it { should respond_to(:name)}
  it { should respond_to(:email)}
  
  it { should be_valid }
  
  describe "when name is not present" do
    before { @user.name = " "}
    it { should_not be_valid}
  end
  
  describe "when email is not present" do
    before { @user.email = " "}
    it { should_not be_valid}
  end
  
  describe "when name is too long" do
    before { @user.email = "a" * 51 }
    it {should_not be_valid }
  end
  
  describe "when email format is invalid" do
    it "should be invalid" do
      addressses = %w[user@foo,com user_at_foo.org exammple.user@foo. forr@foo.]
      addressses.each od |invalid_addresss|
        @user.email = invalid_addresss
        @user.should_not be_valid
      end
    end
    
end
