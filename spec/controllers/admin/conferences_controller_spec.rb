require 'spec_helper'

describe Admin::ConferencesController do

  context "when authorized user" do
    before { sign_in FactoryGirl.create(:admin_user) }

    it "should display index page" do
      get :index
      response.status.should be_eql(200)
    end

    it "should allow to approve conference" do
      put :approve, { id: FactoryGirl.create(:conference).id }
      response.should redirect_to admin_conferences_path
    end
  end

  context "when not authorized as admin" do
    it "should redirect to root path" do
      get :index
      response.should redirect_to root_path
    end
  end

end
