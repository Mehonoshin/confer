class RemoveParticipantIdAndAddOrganizerIdToNewsArticle < ActiveRecord::Migration
  def up
    remove_column :news_articles, :participant_id
    add_column :news_articles, :organizer_id, :integer
  end

  def down
    remove_column :news_articles, :organizer_id
    add_column :news_articles, :participant_id, :integer
  end
end
