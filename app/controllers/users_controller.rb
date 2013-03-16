class UsersController < ApplicationController

  def create
    @user = User.new(params[:user])
    @user.password = params[:user][:password]
    if @user.save
      flash[:notice] = 'Sucessfully registered'
      redirect_to @user
    else
      flash[:notice] = "There were some errors: #{@user.errors.full_messages}"
      render 'new'
    end
  end

  def show
      @user = User.find_by_token(cookies[:token])
    @users =  User.paginate(page:  params[:page]).order('created_at DESC')
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
      if valid_user?
        @user.update_attributes(params[:user])
        flash[:success] = "Updated"
        log_in @user
        redirect_to @user
      else
        flash[:warning] = "You can't edit other user!"
        redirect_to root_path
      end
    end

  private

  def valid_user?
    logged_user?(User.find_by_id(params[:id])) ? true : false
  end

end
