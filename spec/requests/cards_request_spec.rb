require 'rails_helper'

RSpec.describe "Cards", type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "GET /new" do
    it "responds successfully when user logged in" do
      log_in_as(user)
      get new_card_path
      expect(response).to have_http_status(:success)
    end
  end

  # describe "POST /create" do
  #   it "returns http success" do
  #     get "/cards/create"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET /show" do
  #   it "returns http success" do
  #     get "/cards/show"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "DELETE /destroy" do

  # end

end
