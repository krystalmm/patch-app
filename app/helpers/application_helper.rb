module ApplicationHelper
  def card_src(card_brand)
    case card_brand
    when 'Visa'
      card_src = 'icon_visa.png'
    when 'JCB'
      card_src = 'icon_jcb.png'
    when 'MasterCard'
      card_src = 'icon_mastercard.png'
    when 'American Express'
      card_src = 'icon_amex.png'
    when 'Diners Club'
      card_src = 'icon_diners.png'
    when 'Discover'
      card_src = 'icon_discover.png'
    end
    card_src
  end
end
