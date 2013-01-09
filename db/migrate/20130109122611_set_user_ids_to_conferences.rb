class SetUserIdsToConferences < ActiveRecord::Migration
  def up
    Conference.all.each do |conf|
      conf.update_attribute("user_id", User.admins.first.id)
    end
  end

  def down
  end
end
