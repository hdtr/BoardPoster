class UsersController < ApplicationController

  include ActionView::Helpers::TextHelper

  def create
    @user = User.new(params[:user])
    @users ||= User.order('created_at DESC').page params[:page]
    if recaptcha_valid?
        @user.password = params[:user][:password]
        @user.confirmation_code = Base64.encode64(params[:user][:login]).strip
        if @user.save
          UserMailer.activation_email(@user).deliver
          flash[:notice] = "Thank you for registering <strong> #{params[:user][:login]}</strong>, please confirm your email <strong>#{params[:user][:email]}</strong> so you can log in. "
        else
          print_errors
        end

      else
        @user.errors[:Recaptcha] << 'is wrong'
        print_errors

      end
  end

  def index
    @users =  User.order('created_at DESC').page(params[:page])
  end

  def edit
    @user ||= logged_user
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:notice] = "User deleted"
    log_out
  end

  def update
      @user ||= User.find_by_id(params[:id])
      if @user.update_attributes(params[:user])
        flash[:notice] = "Updated"
        log_in @user
      else
        print_errors
      end
  end

  def verify_email
    @user = User.find_by_id(params[:id])
    if @user.confirmed
      flash[:notice] = 'boo'
      flash[:notice] = 'Account has been already confirmed'
    elsif params[:code] == @user.confirmation_code
      @user.confirmed = true
      @user.save(validate: false)
      flash[:notice] = 'Thank you for verifying email address, you can login now'
    else
      flash[:error] = 'Wrong confirmation code!'
    end
  end


end
