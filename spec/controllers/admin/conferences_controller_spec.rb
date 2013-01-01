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

    it "should remove conferences" do
      conf = FactoryGirl.create(:conference)
      Conference.all.count.should be_eql(1)
      delete :destroy, { id: conf.id }
      response.should redirect_to admin_conferences_path
      Conference.all.count.should be_eql(0)
    end
  end

  context "when not authorized" do
    it "should redirect to root path" do
      get :index
      response.should redirect_to new_user_session_path
    end
  end

  context "when authenticated without admin role" do
    before do
      sign_in FactoryGirl.create(:user)
    end

    it "should redirect to root path" do
      get :index
      response.should redirect_to root_url
    end
  end

end
