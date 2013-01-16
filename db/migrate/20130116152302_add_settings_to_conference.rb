class AddSettingsToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :notify_email, :string
    add_column :conferences, :address, :string
    add_column :conferences, :phone, :string
    add_column :conferences, :public_email, :string
    add_column :conferences, :additional_info, :text
    add_column :conferences, :modules, :text
  end
end
