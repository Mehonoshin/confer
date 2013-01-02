require 'spec_helper'

describe ReportsController do
  let(:conference) { FactoryGirl.create(:conference) }

  before(:each) do
    request.expects(:subdomain).returns(conference.domain)
  end

  context "public part requests" do
    it "should return reports list" do
      get :index
      response.status.should be_eql(200)
    end
  end

end
