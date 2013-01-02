require 'spec_helper'

describe ProjectsController do

  it "should render index page" do
    get :index
    response.status.should be_eql(200)
  end

end
