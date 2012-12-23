class Admin::BaseController < ApplicationController
  before_filter :allow_only_admin

  def allow_only_admin
    authorize! :admin, :service
  end

end
