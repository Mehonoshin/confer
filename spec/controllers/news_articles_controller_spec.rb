require 'spec_helper'

describe NewsArticlesController do
  let(:conference) { FactoryGirl.create(:conference) }
  subject { FactoryGirl.create(:news_article) }

  before(:each) do
    request.expects(:subdomain).returns(conference.domain)
  end

  context "when user is guest" do

    it "should allow to view news list" do
      get :index
      response.should render_template("index")
    end

    it "should allow to view separate news article" do
      get :show, {id: subject.id}
      response.should render_template("show")
    end

    it "should not allow to create new article" do
      get :new
      response.should redirect_to new_user_session_path
    end

  end

  context "when user is organizer of conference" do
    let(:user) { FactoryGirl.create(:admin_user) }

    before do
      participant = conference.participants.create(user_id: user.id)
      participant.approve!
      sign_in user
    end

    it "should display news list" do
      get :index
      response.should render_template("index")
    end

    it "should display separate news article" do
      get :show, { id: subject.id }
      response.should render_template("show")
    end

    it "should allow to edit news article" do
      get :edit, { id: subject.id }
      response.should render_template("edit")
    end

    it "should allow to update news article" do
      put :update, { id: subject.id, news_article: FactoryGirl.attributes_for(:news_article) }
      response.should redirect_to news_article_path(subject)
    end

    it "should allow to destroy news article" do
      delete :destroy, { id: subject.id }
      response.should redirect_to news_articles_path
    end

    it "should allow to make new article" do
      get :new
      response.should render_template("new")
    end

    it "should create new article" do
      post :create, { news_article: FactoryGirl.attributes_for(:news_article) }
      response.should redirect_to news_article_path(NewsArticle.last)
    end

  end

end
