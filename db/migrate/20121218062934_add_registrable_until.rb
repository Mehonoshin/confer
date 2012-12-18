class AddRegistrableUntil < ActiveRecord::Migration
  def up
    add_column :conferences, :registrable_until, :datetime
  end

  def down
  end
end
