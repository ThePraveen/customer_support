require 'rails_helper'

RSpec.describe Issue, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe "Validation" do

    let(:user) do
      FactoryGirl.create :user
    end

    before do
      @user = User.first
      @customer = FactoryGirl.create(:customer, user_id: @user.id)
    end

    it "checks if user object is loaded" do
      puts @user.inspect
      puts @customer.inspect
      puts "Total users #{User.count}"
      puts "Total customers #{Customer.count}"
    end
 
    it "Check if issues create throws validation" do
      @issue = Issue.create(customer_id: @customer.id)
      puts @issue.inspect
    end
  end
end
