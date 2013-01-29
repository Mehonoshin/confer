class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    if signed_in?
      redirect_to root_url, alert: exception.message
    else
      redirect_to new_user_session_path, alert: exception.message
    end
  end

  before_filter :set_title

  private

    def current_ability
      @current_ability ||= Ability.new(current_user, @conference)
    end

    def set_title
      @page_title = t("titles.#{params[:controller].gsub("/", ".")}.#{params[:action]}")
    end
end
