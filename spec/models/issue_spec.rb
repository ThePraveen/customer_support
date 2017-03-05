require 'rails_helper'

RSpec.describe Issue, type: :model do
  describe "Validation" do

    let(:user) do
      FactoryGirl.create :user
    end

    before do
      @user = User.first
      @customer = FactoryGirl.create(:customer, user_id: @user.id)
    end

    it "Check if issues creation throws validation error when title and description are blank" do
      @issue = Issue.create
      puts @issue.errors.messages
      #@issue = Issue.create(customer_id: @customer.id)
      expect(@issue.errors.messages[:title]).to eq ["can't be blank"]
      expect(@issue.errors.messages[:description]).to eq ["can't be blank"]
    end

    it "Check if issues creation throws validation error when description is blank" do
      @issue = Issue.create(customer_id: @customer.id, title: "Not able to start")
      expect(@issue.errors.messages[:description]).to eq ["can't be blank"]
    end

    it "Check if issues creation throws validation error when title is blank" do
      @issue = Issue.create(customer_id: @customer.id, description: "It's very complicated")
      expect(@issue.errors.messages[:title]).to eq ["can't be blank"]
    end

    it "Check if issues are getting created with correct values and correct status got assigned" do
      @issue = Issue.create(customer_id: @customer.id, title: "Not able to start", description: "It's very complicated")
      expect(@issue.title).to eq "Not able to start"
      expect(@issue.description).to eq "It's very complicated"
      expect(@issue.status).to eq "created"
    end
  end
end
