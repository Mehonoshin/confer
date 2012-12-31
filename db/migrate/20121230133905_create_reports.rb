class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :participant_id
      t.integer :conference_id
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
