require 'spec_helper'

describe MainController do

  it "should display main page" do
    get "index"
    response.status.should be_eql(200)
  end

end
