require 'spec_helper'

describe Admin::UsersController do
  let(:admin) { FactoryGirl.create(:user, service_admin: true) }

  context "when not authorized" do
    it "should redirect to too page" do
      get :index
      response.should redirect_to root_url
    end
  end

  context "when user is admin" do
    before(:each) do
      sign_in admin
    end

    it "should render page" do
      get :index
      response.status.should be_eql(200)
    end
  end

end

