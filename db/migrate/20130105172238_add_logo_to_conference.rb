class AddLogoToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :logo, :string
  end
end
