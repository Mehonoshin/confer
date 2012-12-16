class Organizer < ActiveRecord::Base
  attr_accessible :conference_id, :role, :role_description, :user_id
end
