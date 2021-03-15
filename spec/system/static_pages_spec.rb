require 'rails_helper'

RSpec.describe 'StaticPages', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe '#home' do
    before do
      visit root_path
    end

    it "has title 'ライフウェーブパッチ販売サイト | LifeWave'" do
      expect(page).to have_title('ライフウェーブパッチ販売サイト | LifeWave')
    end
  end
end
