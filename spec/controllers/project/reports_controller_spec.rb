require 'spec_helper'

describe Project::ReportsController do
  let(:user) { FactoryGirl.create(:admin_user) }
  let(:conference) { FactoryGirl.create(:conference) }
  let(:participant) { FactoryGirl.create(:participant, user_id: user.id) }
  let(:report) { FactoryGirl.create(:report, participant_id: participant.id) }

  before(:each) do
    request.expects(:subdomain).returns(conference.domain)
  end

  context "public part requests" do
    it "should return reports list" do
      get :index
      response.status.should be_eql(200)
    end

    it "should not allow to approve reports" do
      delete :destroy, { id: report.id }
      response.should redirect_to new_user_session_path
    end

    it "should not allow to approve reports" do
      put :approve, { id: report.id }
      response.should redirect_to new_user_session_path
    end
  end

  context "should allow to moderate reports" do

    before(:each) do
      sign_in user
    end

    it "should allow to edit report" do
      put :update, { id: report.id, report: FactoryGirl.attributes_for(:report) }
      response.should redirect_to edit_report_path(report)
    end

    it "should allow to approve report" do
      put :approve, { id: report.id }
      response.should redirect_to reports_path
    end

    it "should allow to delete report" do
      delete :destroy, { id: report.id }
      response.should redirect_to reports_path
    end
  end

end
