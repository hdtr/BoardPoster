module UsersHelper


  def print_errors
    flash[:error] = "There were #{pluralize(@user.errors.count, 'error')}:<br />"
    flash[:error] << @user.errors.full_messages.join('<br />')
  end

end
