class SessionsController < ApplicationController

  include Rack::Recaptcha::Helpers

  def new
  end

  def create
    begin
      if params[:commit] == "Register"
        redirect_to register_path
      else
        # refactor that if/if/if/if
        if  params[:session][:login].empty?
        raise "Login can't be blank"
        end
        @user = User.find_by_login(params[:session][:login])
        if @user.nil?
          raise "User #{params[:session][:login]} not found"
        end
        if @user.authenticate(params[:session][:password])
          if confirmed_email?

            log_in @user
            redirect_to users_url
          else
            flash[:error] = "Error! #{@user.errors.full_messages}"
            render 'new'
          end
        else
          flash[:error] = "Email not verified!"
          redirect_to login_path
        end
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
