module SessionsHelper

  def log_in(user)
    cookies.permanent[:token] = user.token
    self.logged_user = user
  end

  def logged_in?
    !logged_user.nil?
  end

  def log_out
    @logged_user = nil
    cookies.delete(:token)
  end

  def logged_user=(user)
    @logged_user = user
  end

  def logged_user?(user)
    user == logged_user
  end

  def logged_user
    @logged_user ||= User.find_by_token(cookies[:token])
  end

  def visited_page
    root_path
  end

end
