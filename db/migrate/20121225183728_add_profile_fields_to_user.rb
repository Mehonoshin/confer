class AddProfileFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :country, :string
    add_column :users, :city, :string
    add_column :users, :full_name, :string
    add_column :users, :phone, :string
    add_column :users, :about, :text
  end
end
