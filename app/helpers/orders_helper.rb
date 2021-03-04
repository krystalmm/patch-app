module OrdersHelper
  def has_card
    Card.find_by(user_id: current_user.id)
  end
end
