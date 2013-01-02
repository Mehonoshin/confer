require 'spec_helper'

describe ParticipantsController do
  subject { FactoryGirl.create(:participant) }
  let(:user) { FactoryGirl.create(:user) }
  let(:conference) { FactoryGirl.create(:conference) }

  context "when authorized" do
    before(:each) do
      sign_in user
      request.expects(:subdomain).returns(conference.domain)
    end

    context "creating participation" do
      it "should redirect to conference path" do
        post :create, participant: FactoryGirl.attributes_for(:participant, :reports_attributes => { "0" => FactoryGirl.attributes_for(:report) })
        response.should redirect_to "http://#{conference.domain}.test.host/"
      end
    end
  end

  context "when guest" do
    before(:each) do
      request.expects(:subdomain).returns(conference.domain)
    end

    it "should redirect to root url from new participant form" do
      get :new
      response.should redirect_to new_user_session_path
    end

    it "should redirect to root url from create action" do
      post :create, participant: FactoryGirl.attributes_for(:participant)
      response.should redirect_to new_user_session_path
    end

    it "should display participants list" do
      get :index
      response.status.should be_eql(200)
    end
  end

end
