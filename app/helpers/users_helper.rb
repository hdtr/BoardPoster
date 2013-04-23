module UsersHelper

  def print_errors
    flash[:error] = "There were #{pluralize(@user.errors.count, 'error')}:<br />"
    flash[:error] << @user.errors.full_messages.join('<br />')
  end

  def create_conf_code(user)
    user.confirmation_code = Base64.encode64(user.login).strip
  end

end
