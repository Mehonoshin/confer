class AddThemeToConferences < ActiveRecord::Migration
  def change
    add_column :conferences, :theme, :string
  end
end
