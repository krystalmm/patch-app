require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe "#home" do
    before do
      get :home
    end

    it "responds successfully" do
      expect(response).to be_successful
    end
  end

  describe "#contact" do
    before do
      get :contact
    end

    it "responds successfully" do
      expect(response).to be_successful
    end
  end

  describe "#support" do
    before do
      get :support
    end

    it "responds successfully" do
      expect(response).to be_successful
    end
  end
end