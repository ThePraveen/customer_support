require "rails_helper"

RSpec.describe IssueTypesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/issue_types").to route_to("issue_types#index")
    end

    it "routes to #new" do
      expect(:get => "/issue_types/new").to route_to("issue_types#new")
    end

    it "routes to #show" do
      expect(:get => "/issue_types/1").to route_to("issue_types#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/issue_types/1/edit").to route_to("issue_types#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/issue_types").to route_to("issue_types#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/issue_types/1").to route_to("issue_types#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/issue_types/1").to route_to("issue_types#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/issue_types/1").to route_to("issue_types#destroy", :id => "1")
    end

  end
end
