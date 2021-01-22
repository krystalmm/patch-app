require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "#home" do
    before do
      visit root_path
    end

    it "has title 'ライフウェーブパッチ販売サイト | LifeWave'" do
      expect(page).to have_title("ライフウェーブパッチ販売サイト | LifeWave")
    end
  end

  describe "#contact" do
    before do
      visit contact_path
    end

    it "has title 'お問い合わせ | ライフウェーブパッチ販売サイト'" do
      expect(page).to have_title("お問い合わせ | ライフウェーブパッチ販売サイト")
    end
  end

  describe "#support" do
    before do
      visit support_path
    end

    it "has title 'ご注文の流れ | ライフウェーブパッチ販売サイト'" do
      expect(page).to have_title("ご注文の流れ | ライフウェーブパッチ販売サイト")
    end
  end

  describe "#about" do
    before do
      visit about_path
    end

    it "has title 'LifeWaveパッチについて | ライフウェーブパッチ販売サイト'" do
      expect(page).to have_title("LifeWaveパッチについて | ライフウェーブパッチ販売サイト")
    end
  end
end
