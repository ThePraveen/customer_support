require 'rails_helper'

RSpec.describe Comment, type: :model do
    describe "Validation" do

    let(:user) do
      FactoryGirl.create :user
    end

    before do
      @user = User.first
      @customer = FactoryGirl.create(:customer, user_id: @user.id)
      @issue = Issue.create(customer_id: @customer.id, title: "Not able to start", description: "It's very complicated")
    end

    it "Checks if comment creation throws validation error when user, issue and body are blank" do
      @comment = Comment.create
      expect(@comment.errors.messages[:issue]).to eq ["must exist"]
      expect(@comment.errors.messages[:user_id]).to eq ["can't be blank"]
      expect(@comment.errors.messages[:body]).to eq ["can't be blank"]
    end

    it "Checks if comments creation throws validation error when body is blank" do
      @comment = Comment.create(issue_id: @issue.id, user_id: @user.id)
      expect(@comment.errors.messages[:body]).to eq ["can't be blank"]
    end

    it "Checks if comments creation throws validation error when user is blank" do
      @comment = Comment.create(issue_id: @issue.id, body: "It's very complicated")
      expect(@comment.errors.messages[:user_id]).to eq ["can't be blank"]
    end

    it "Checks if comments are getting created with correct values and correct status got assigned" do
      @comment = Comment.create(issue_id: @issue.id, user_id: @user.id, body: "It's very complicated")
      expect(@comment.user_id).to eq @user.id
      expect(@comment.body).to eq "It's very complicated"
      expect(@comment.issue_id).to eq @issue.id
    end
  end
end
