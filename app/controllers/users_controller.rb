class UsersController < ApplicationController

  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::OutputSafetyHelper
  include UsersHelper

  before_filter :set_users, only: [:create, :index, :destroy, :update]


  def create
    @user = User.new(params[:user])
    if recaptcha_valid?
        @user.password = params[:user][:password]
        create_conf_code(@user)
        if @user.save
          #TODO: check here if mail has been sent successfully
          send_conf
          flash[:notice] = "Thank you for registering <strong> #{params[:user][:login]}</strong>, please confirm your email <strong>#{params[:user][:email]}</strong> so you can log in. "
        else
          print_errors
        end

      else
        @user.errors[:Recaptcha] << 'is wrong'
        print_errors
      end
  end

  def send_conf
    @user = User.find_by_id(params[:id])
    UserMailer.activation_email(@user).deliver
    flash[:notice] = 'Email has been sent, please check your email'
    redirect_to :root
  end

  def index
  end

  def edit
    @user ||= logged_user
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:notice] = 'User deleted'
    log_out
  end

  def update
      @user ||= User.find_by_id(params[:id])
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Updated'
        log_in @user
      else
        print_errors
      end
  end

  def verify_email
    @user = User.find_by_id(params[:id])
    if @user.confirmed
      flash[:notice] = 'Account has been already confirmed'
      redirect_to :root
    elsif params[:code] == @user.confirmation_code
      @user.confirmed = true
      @user.save(validate: false)
      flash[:notice] = 'Thank you for verifying email address, you can login now'
      redirect_to :root
    else
      #TODO: html directly from controller? smells fishy...
      flash[:error] = raw('Wrong confirmation code!<br />')
      flash[:error] << raw("#{self.class.helpers.link_to('Click here', send_conf_path(params))} to send another confirmation email")
      redirect_to :root
    end
  end



end
