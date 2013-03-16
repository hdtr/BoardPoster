class SessionsController < ApplicationController

  def new
  end

  def create
      user = User.find_by_login(params[:session][:login])
      if user && user.authenticate(params[:session][:password])
        log_in user
        redirect_to root_url
      else
        flash.now[:error] = 'Invalid email/password combination'
        render 'new'
      end
    end

  def destroy
    log_out
    redirect_to root_url
  end
end
