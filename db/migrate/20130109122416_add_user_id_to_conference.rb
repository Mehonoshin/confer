class AddUserIdToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :user_id, :integer
  end
end
