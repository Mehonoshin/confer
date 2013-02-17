class AddDisplayInMenuToPage < ActiveRecord::Migration
  def change
    add_column :pages, :display_in_menu, :boolean, default: false
  end
end
