require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe '#home' do
    it 'responds successfully' do
      get :home
      expect(response).to be_successful
    end
  end

  describe '#contact' do
    it 'responds successfully' do
      get :contact
      expect(response).to be_successful
    end
  end

  describe '#support' do
    it 'responds successfully' do
      get :support
      expect(response).to be_successful
    end
  end

  describe '#about' do
    it 'responds successfully' do
      get :about
      expect(response).to be_successful
    end
  end
end
