class SessionsController < ApplicationController

  include Rack::Recaptcha::Helpers

  def new
  end

  def create
    begin
      @user = User.find_by_login(params[:session][:login])
      # refactor that if/if/if
        if recaptcha_valid?
            if @user.authenticate(params[:session][:password])
              if confirmed_email?

                log_in @user
            redirect_to users_url
          else
            flash[:error] =  "Error! #{@user.errors.full_messages}"
            render 'new'
          end
        else
          flash[:error] = "Email not verified!"
          redirect_to login_path
        end
      else
        flash[:error] = "Wrong code!"
        redirect_to login_path
      end
    rescue => er
      flash[:error] = "Errors: #{er.message}"
      redirect_to :back
      end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
