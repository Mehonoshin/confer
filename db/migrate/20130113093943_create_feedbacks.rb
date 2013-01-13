class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :user_id
      t.string :email
      t.string :title
      t.text :body
      t.integer :conference_id
      t.string :state

      t.timestamps
    end
  end
end
