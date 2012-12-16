class Participant < ActiveRecord::Base
  attr_accessible :conference_id, :state, :user_id
end
