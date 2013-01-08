require 'spec_helper'

describe NewsArticle do
  subject { FactoryGirl.build(:news_article) }

  it { should be_valid }

  context "when invalid" do
    subject { FactoryGirl.build(:news_article, title: nil, body: nil) }

    before { subject.valid? }

    it "should require title" do
      subject.errors[:title].should_not be_empty
    end

    it "should require body" do
      subject.errors[:body].should_not be_empty
    end

  end
end
