require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: User.first}
      expect(response).to have_http_status(:success)
    end

    it "returns http failure" do
      get :show, {id: Time.now.to_i}
      expect(response).to have_http_status(:not_found)
    end
  end
end
