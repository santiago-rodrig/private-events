module SessionsHelper
  def logged_in?
    !controller.session[:user_id].nil?
  end
end
