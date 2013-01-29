require 'spec_helper'

describe Project::MaterialsController do
  let(:conference_creator) { create(:user) }
  let(:conference) { create(:conference, user_id: conference_creator.id) }

  before(:each) do
    request.expects(:subdomain).returns(conference.domain)
  end

  context "when guest" do
    it "should allow to read materials list" do
      get :index
      response.should render_template("index")
      response.status.should be_eql(200)
    end

    it "should not allow to create new material" do
      get :new
      response.should redirect_to new_user_session_path
    end
  end

  context "when is not participant" do
    let(:non_participant) { create(:user) }
    before { sign_in non_participant }

    it "should now allow to create new material" do
      get :new
      response.should redirect_to root_path
    end
  end

  context "when is participant" do
    let(:participant_user) { create(:user) }

    before(:each) do
      sign_in participant_user
      conference.participants.create!(user_id: participant_user.id)
    end

    it "should allow to create new material" do
      get :new
      response.should render_template("new")
      response.status.should be_eql(200)
    end

    it "should allow to upload files" do
      pending "Dont know how to upload file in the test"
      attrs = attributes_for(:material)
      attrs[:file] = File.open(Rails.root.join("spec", "fixtures", "files", "gerb.gif"))
      post :create, { material: attrs }
      response.should redirect_to materials_path
      response.should include(attributes_for(:material)[:name])
    end
  end

  context "when is admin" do
    let(:admin_user) { create(:admin_user) }
    let(:material) { create(:material, user_id: admin_user.id, conference_id: conference.id) }

    before do
      sign_in admin_user
    end

    it "should allow to create new material" do
      get :new
      response.should render_template("new")
      response.status.should be_eql(200)
    end

    it "should allow admin to approve material" do
      put :approve, { id: material.id }
      response.should redirect_to materials_path
      Material.find(material.id).state.should be_eql("approved")
    end

    it "should allow admin to destroy material" do
      delete :destroy, { id: material.id }
      response.should redirect_to materials_path
    end

  end
end
