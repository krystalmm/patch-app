require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { FactoryBot.create(:user) }
  describe "password_reset" do
    before { user.reset_token = User.new_token }
    let(:mail) { UserMailer.password_reset(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("パスワードの再設定について")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply-lifewave@example.com"])
    end

    it "renders the body" do
      expect(mail.text_part.body.encoded).to match user.reset_token
      expect(mail.html_part.body.encoded).to match user.reset_token
      expect(mail.text_part.body.encoded).to match CGI.escape(user.email)
      expect(mail.html_part.body.encoded).to match CGI.escape(user.email)
    end
  end

end
