class Admin::UsersController < Admin::BaseController
  before_filter :preload_user, only: [:make_admin, :make_user, :confirm, :destroy]

  def index
    @users = User.order("id ASC").page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @audits = @user.audits
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: t('admin.users.notices.removed')
  end

  def make_admin
    @user.admin!
    redirect_to admin_users_path, notice: t('admin.users.notices.made_admin')
  end

  def make_user
    @user.user!
    redirect_to admin_users_path, notice: t('admin.users.notices.made_user')
  end

  def confirm
    @user.confirm!
    redirect_to admin_users_path, notice: t('admin.users.notices.confirmed')
  end

  private

    def preload_user
      @user = User.find(params[:id])
    end

end
