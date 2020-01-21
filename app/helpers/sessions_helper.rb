module SessionsHelper
  def logged_in?
    !controller.session[:user_id].nil?
  end

  def current_user
    logged_in? ? User.find(controller.session[:user_id]) : nil
  end
end
