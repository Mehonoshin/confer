class AddStateToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :state, :string
  end
end
