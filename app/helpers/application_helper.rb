module ApplicationHelper
  def create_stat(current_user, card_id)
    stat = current_user.stats.build
    stat.card_id = card_id
    stat.save
  end
end
