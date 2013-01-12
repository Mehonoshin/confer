require 'spec_helper'

describe OrganizersController do
  let(:admin) { FactoryGirl.create(:admin_user)}
  let(:conference) { FactoryGirl.create(:conference) }
  let(:user) { FactoryGirl.create(:user) }
  let(:organizer) { FactoryGirl.create(:organizer, user_id: user.id, conference_id: conference.id) }

  before(:each) do
    request.expects(:subdomain).returns(conference.domain)
  end

  context "when user is guest" do
    it "should not allow to maage organizers" do
      get :index
      response.should redirect_to new_user_session_path
    end
  end

  context "when user is conference owner" do
    before do
      sign_in admin
    end

    it "should display organizers list" do
      get :index
      response.should render_template("index")
      response.status.should be_eql(200)
    end

    it "should allow to add organizer" do
      get :new
      response.should render_template("new")
      response.status.should be_eql(200)
    end

    it "should allow do delete organizer" do
      delete :destroy, { id: organizer.id }
      response.should redirect_to organizers_path
    end

    it "should create organizer" do
      post :create, { organizer: {email: user.email, role: "owner"} }
      response.should redirect_to organizers_path
    end
  end

end
