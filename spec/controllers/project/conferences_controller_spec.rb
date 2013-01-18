require 'spec_helper'

describe Project::ConferencesController do

  let(:owner) { FactoryGirl.create(:user) }
  subject { FactoryGirl.create(:conference, user_id: owner.id) }

  context "when guest" do
    before do
      request.expects(:subdomain).returns(subject.domain)
    end

    it "should not allow to access settings page" do
      get :edit
      response.should redirect_to new_user_session_path
    end
  end

  context "when editing on conference site" do
    before(:each) do
      request.expects(:subdomain).returns(subject.domain)
      sign_in owner
    end

    it "should allow to edit conference settings" do
      get :edit
      response.should render_template("edit")
      response.status.should be_eql(200)
    end

    it "should save conference settigns" do
      put :update, { id: subject.id, conference: FactoryGirl.attributes_for(:conference) }
      response.should redirect_to settings_path
    end
  end

end
