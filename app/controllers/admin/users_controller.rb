class Admin::UsersController < Admin::BaseController
  before_filter :preload_user, only: [:make_admin, :make_user, :confirm, :destroy]

  def index
    @users = User.order("id ASC").page(params[:page])
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  def make_admin
    @user.update_attribute("service_admin", true)
    redirect_to admin_users_path
  end

  def make_user
    @user.update_attribute("service_admin", false)
    redirect_to admin_users_path
  end

  def confirm
    @user.confirm!
    redirect_to admin_users_path
  end

  private

    def preload_user
      @user = User.find(params[:id])
    end

end
