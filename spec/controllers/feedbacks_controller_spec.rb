require 'spec_helper'

describe FeedbacksController do
  let(:user) { FactoryGirl.create(:user) }
  let(:conference) { FactoryGirl.create(:conference, user_id: user.id) }
  let(:feedback) { FactoryGirl.create(:feedback, conference_id: conference.id) }

  context "when user is authenticated as conference owner" do
    before do
      sign_in user
      request.expects(:subdomain).returns(conference.domain)
    end

    it "should display feedbacks list" do
      get :index
      response.status.should be_eql(200)
      response.should render_template("index")
    end

    it "should display feedbacks list" do
      get :show, {id: feedback.id}
      response.status.should be_eql(200)
      response.should render_template("show")
    end

    it "should mark feedback as read" do
      get :show, {id: feedback.id}
      Feedback.last.read?.should be_true
    end

    it "should not mark feedback as read if its already read" do
      get :show, {id: feedback.id}
      response.status.should be_eql(200)
    end

    it "should allow to destroy feedback" do
      delete :destroy, {id: feedback.id}
      response.should redirect_to feedbacks_path
    end
  end

  context "when user is not signed in" do
    it "should not allow access to feedbacks admin page" do
      get :index
      response.should redirect_to new_user_session_path
    end
  end

end
