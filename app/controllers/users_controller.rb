class UsersController < ApplicationController

  def create
    @user = User.new(params[:user])
    @user.password = params[:user][:password]
    if @user.save
      flash[:notice] = 'Sucessfully registered'
      log_in(@user)
      index
      render 'index'
    else
      flash[:notice] = "There were some errors: #{@user.errors.full_messages}"
      render 'new'
    end
  end

  def index
    @user = User.find_by_token(cookies[:token])
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

  private

  def valid_user?
    logged_user?(User.find_by_id(params[:id])) ? true : false
  end

end
