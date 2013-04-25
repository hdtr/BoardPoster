class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  after_filter :flash_to_headers, only: [:create, :destroy, :update, :verify_email]
  before_filter :set_cache_buster
  before_filter :copy_params_to_session



# Method of flashing flash messages with ajax requests in Rails, source here: https://gist.github.com/linjunpop/3410235

  private

  def flash_to_headers
    return unless request.xhr?
    response.headers['X-Message'] = flash_message
    response.headers['X-Message-Type'] = flash_type.to_s

    flash.discard # don't want the flash to appear when you reload page
  end

  def flash_message
    [:error, :warning, :notice].each do |type|
      return flash[type] unless flash[type].blank?
    end
  end

  def flash_type
    [:error, :warning, :notice].each do |type|
      return type unless flash[type].blank?
    end
  end

  # remove header caching for ajax requests so there won't be strange errors
  def set_cache_buster
    return unless request.xhr?
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def set_users
    @users = User.order('created_at DESC').page(params[:page])\
    .per(params[:record_amount] ||= session[:record_amount])
  end

  #TODO: params-to-session part 2 - do refactor so that silly method won't be necessary
  def copy_params_to_session
    session[:record_amount] = (params[:record_amount] ||= session[:record_amount])
    # It is harder to do with page as page = nil equals first page, find some better way or patch Kaminari (rly?)
  end

end
