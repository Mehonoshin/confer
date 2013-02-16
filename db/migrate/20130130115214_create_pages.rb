class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :body
      t.string :permalink
      t.integer :conference_id

      t.timestamps
    end
  end
end
