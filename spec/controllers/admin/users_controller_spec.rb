require 'spec_helper'

describe Admin::UsersController do
  let(:admin) { FactoryGirl.create(:user, service_admin: true) }
  let(:user) { FactoryGirl.create(:user) }

  context "when not authorized" do
    it "should redirect to too page" do
      get :index
      response.should redirect_to new_user_session_path
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

    it "should remove user" do
      delete :destroy, { id: user.id }
      response.should redirect_to admin_users_path
      User.all.count.should be_eql(1)
    end

    it "should make admin" do
      put :make_admin, { id: user.id }
      response.should redirect_to admin_users_path
      User.find(user.id).admin?.should be_true
    end

    it "should make back user" do
      user.admin!
      put :make_user, { id: user.id }
      response.should redirect_to admin_users_path
      User.find(user.id).admin?.should be_false
    end

    it "should confirm user" do
      user = FactoryGirl.create(:user, confirmed_at: nil)
      put :confirm, { id: user.id }
      response.should redirect_to admin_users_path
      User.find(user.id).confirmed?.should be_true
    end
  end
end

