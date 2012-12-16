class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.integer :user_id
      t.integer :conference_id
      t.string :state

      t.timestamps
    end
  end
end
