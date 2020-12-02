module ApplicationHelper

  def delete_session
    session.delete(:current_user_id)
  end
end
