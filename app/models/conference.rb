class Conference < ActiveRecord::Base
  attr_accessible :end_date, :max_guests, :name, :start_date
end
