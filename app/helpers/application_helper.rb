module ApplicationHelper
  def root_path_for_current_user
    user_signed_in? ? authenticated_root_path : unauthenticated_root_path
  end
end
