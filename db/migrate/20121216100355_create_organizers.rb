class CreateOrganizers < ActiveRecord::Migration
  def change
    create_table :organizers do |t|
      t.integer :user_id
      t.integer :conference_id
      t.string :role
      t.string :role_description

      t.timestamps
    end
  end
end
