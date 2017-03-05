require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Roles" do
    let(:user1) do
      FactoryGirl.create :user1
    end

    before do
      Role.create!(:name => :customer)
      Role.create!(:name => :executive)
      Role.create!(:name => :admin)
      @user = User.last
    end

    it "Checks if admin role is added" do
      @user.add_roles ["admin"]
      expect(@user.customer.inspect).should_not be nil
    end

    it "Checks if executive role is added" do
      @user.add_roles ["executive"]
      expect(@user.customer.inspect).should_not be nil
    end

    it "Checks if customer role is added" do
      @user.add_roles ["customer"]
      expect(@user.customer.inspect).should_not be nil
    end
  end
end
