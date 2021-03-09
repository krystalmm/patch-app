require "rails_helper"

RSpec.describe OrderMailer, type: :mailer do
  let(:user) { FactoryBot.create(:user) }
  let(:product) { FactoryBot.create(:product) }
  let(:order) { FactoryBot.create(:order, user_id: user.id, product_id: product.id) }
  let(:mail) { OrderMailer.send_when_order(user, order, order.products) }

  it 'renders the headers' do
    expect(mail.subject).to eq('ご注文内容の詳細')
    expect(mail.to).to eq([user.email])
    expect(mail.from).to eq(['noreply-lifewave@example.com'])
  end

  it 'renders the body' do
    expect(mail.body).to match user.email
    expect(mail.body).to match order.id.to_s
    expect(mail.body).to match user.name
    expect(mail.body).to match order.quantity.to_s
  end
end
