class CreateNewsArticles < ActiveRecord::Migration
  def change
    create_table :news_articles do |t|
      t.string :title
      t.text :body
      t.integer :conference_id
      t.integer :participant_id

      t.timestamps
    end
  end
end
