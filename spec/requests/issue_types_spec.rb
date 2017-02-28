require 'rails_helper'

RSpec.describe "IssueTypes", type: :request do
  describe "GET /issue_types" do
    it "works! (now write some real specs)" do
      get issue_types_path
      expect(response).to have_http_status(200)
    end
  end
end
