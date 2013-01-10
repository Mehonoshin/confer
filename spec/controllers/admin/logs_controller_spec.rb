require 'spec_helper'

describe Admin::LogsController do

  context "when guest" do
    it "should now allow access" do
      get :index
      response.should redirect_to new_user_session_path
    end
  end

  context "when authorized admin user" do
    let(:user) { FactoryGirl.create(:admin_user) }
    before do
      sign_in user
    end

    it "should display index logs page" do
      get :index
      response.status.should be_eql(200)
    end

    it "should display users actions list" do
      get :index, { type: "user" }
      response.status.should be_eql(200)
    end

    it "should display conferences actions list" do
      get :index, { type: "conference" }
      response.status.should be_eql(200)
    end
  end
end
