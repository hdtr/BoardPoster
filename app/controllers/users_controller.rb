class UsersController < ApplicationController

  def create
    @user = User.new(params[:user])
    @user.password = params[:user][:password]
    @user.confirmation_code = Base64.encode64(params[:user][:login]).strip
    if @user.save
      UserMailer.activation_email(@user).deliver
      flash[:notice] = 'Sucessfully registered, please confirm email to login'
      redirect_to root_path
    else
      flash[:notice] = "There were some errors: #{@user.errors.full_messages}"
      render 'new'
    end
  end

  def index
    #@user ||= User.find_by_token(cookies[:token])
    @users =  User.paginate(page: params[:page], per_page: params[:per_page]).order('created_at DESC')
  end

  def new
    @user = User.new
  end

  def edit
    @user ||= logged_user
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    index
    render 'index'
  end

  def update
    @user = User.find_by_id(params[:id])
      if @user.update_attributes(params[:user])
        flash[:notice] = "Updated"
        log_in @user
        redirect_to users_path
      else
        flash[:error] = "Error! #{@user.errors.full_messages}"
        redirect_to :back
      end
    end


  def verify_email
    user = User.find_by_id(params[:id])
    if user.confirmed
      flash[:notice] = "Account has been already confirmed"
      redirect_to login_path
    elsif params[:code] == user.confirmation_code
      user.confirmed = true
      user.save(validate: false)
      flash[:notice] = "Thank you for verifying email address, you can login now"
      redirect_to login_path
    else
      render 'users/wrong_code'
    end
  end


end
