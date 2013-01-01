require 'spec_helper'

describe ParticipantsController do
  subject { FactoryGirl.create(:participant) }
  let(:user) { FactoryGirl.create(:user) }
  let (:conference) { FactoryGirl.create(:conference) }

  # TODO
  # how to pass nested attributes to factory
  context "when authorized", pending: true do
    before(:each) do
      sign_in user
      request.expects(:subdomain).returns(conference.domain)
    end

    context "creating participation" do
      it "should redirect to conference path" do
        post :create, participant: FactoryGirl.attributes_for(:participant)
        response.should redirect_to conference_path(conference)
      end
    end
  end

  context "when guest" do
    it "should redirect to root url from new participant form" do
      get :new
      response.should redirect_to new_user_session_path
    end

    it "should redirect to root url from create action" do
      post :create, participant: FactoryGirl.attributes_for(:participant)
      response.should redirect_to new_user_session_path
    end
  end

end
