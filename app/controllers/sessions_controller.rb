class SessionsController < ApplicationController

  before_filter :load, :set_users

  def load
    @user ||= User.new
  end

  def create
    if User.find_by_login(params[:session][:login])
       @user = User.find_by_login(params[:session][:login])
       if @user.authenticate(params[:session][:password])
         if @user.confirmed?
           log_in(@user)
           flash[:notice] = 'You have successfully logged in!'
         else
           flash[:error] = 'You have not confirmed email!'
           render 'users/send_confirmation'
           end
       else
         flash[:error] = 'Wrong password!'
        end
    else
      flash[:error] = 'Wrong login and/or password!'
    end
  end

  def destroy
    log_out
    flash[:notice] = 'You have logged out!'
  end

end
