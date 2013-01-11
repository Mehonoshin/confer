require 'spec_helper'

describe ProjectsController do
  let(:conference) { FactoryGirl.create(:conference) }

  before do
    request.expects(:subdomain).returns(conference.domain)
  end

  it "should render index page" do
    get :index
    response.status.should be_eql(200)
  end

end
