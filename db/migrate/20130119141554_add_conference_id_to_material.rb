class AddConferenceIdToMaterial < ActiveRecord::Migration
  def change
    add_column :materials, :conference_id, :integer
  end
end
