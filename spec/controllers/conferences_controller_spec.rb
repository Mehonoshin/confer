require 'spec_helper'

describe ConferencesController do

  let(:owner) { FactoryGirl.create(:user) }
  subject { FactoryGirl.create(:conference, user_id: owner.id) }

  context "when guest" do
    it "should return conferences list" do
      get :index
      response.status.should be_eql(200)
    end

    it "should return conference page" do
      get :show, id: subject.id
      response.status.should be_eql(200)
    end

    it "should redirect to root path on creating record" do
      post :create, conference: FactoryGirl.attributes_for(:conference)
      response.should redirect_to root_url
    end
  end

  context "when authorized" do
    before(:each) do
      sign_in owner
    end

    it "should redirect to conference page on create" do
      post :create, conference: FactoryGirl.attributes_for(:conference)
      response.should redirect_to Conference.last
    end
  end

end
