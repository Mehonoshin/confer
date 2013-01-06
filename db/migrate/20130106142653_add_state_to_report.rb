class AddStateToReport < ActiveRecord::Migration
  def change
    add_column :reports, :state, :string, default: "pending"
  end
end
