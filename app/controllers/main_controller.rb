class MainController < ApplicationController

  def index
    @conferences = Conference.with_state(:approved).future(Time.now).random.limit(3)
  end

end
