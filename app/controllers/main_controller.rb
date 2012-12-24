class MainController < ApplicationController

  def index
    @conferences = Conference.future(Time.now).random.limit(3)
  end

end
