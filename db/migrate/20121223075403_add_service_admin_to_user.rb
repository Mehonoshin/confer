class AddServiceAdminToUser < ActiveRecord::Migration
  def change
    add_column :users, :service_admin, :boolean, default: false
    User.first.update_attribute("service_admin", true)
  end
end
