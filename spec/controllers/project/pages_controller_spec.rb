require 'spec_helper'

describe Project::PagesController do
  let(:admin_user) { FactoryGirl.create(:admin_user) }
  let(:conference) { FactoryGirl.create(:conference) }
  subject { FactoryGirl.create(:page) }

  before do
    request.expects(:subdomain).returns(conference.domain)
  end

  context "when authorized" do
    before do
      sign_in admin_user
    end

    it "should be able to see pages list" do
      get :index
      response.should render_template :index
      response.status.should be_eql 200
    end

    it "should be able to create new page" do
      get :new
      response.status.should be_eql 200
      response.should render_template :new
    end

    it "should be able to edit page" do
      get :edit, id: subject.permalink
      response.should render_template :edit
      response.status.should be_eql 200
    end

    it "should be adble to update" do
      put :update, { id: subject.permalink, page: attributes_for(:page) }
      response.should redirect_to pages_path
    end

    it "should allow to destroy" do
      delete :destroy, id: subject.permalink
      response.should redirect_to pages_path
    end

  end

  context "when not authorized" do
    it "should display page content" do
      get :show, id: subject.permalink
      response.status.should be_eql 200
      response.should render_template :show
    end

    it "should not be able to see pages list" do
      get :index
      response.should redirect_to new_user_session_path
    end

  end

end
