module OrdersHelper
  def card?
    Card.find_by(user_id: current_user.id)
  end
end
