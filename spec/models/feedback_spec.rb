require 'spec_helper'

describe Feedback do
  let(:user) { FactoryGirl.create(:user) }

  context "when record is new" do
    let(:conference) { FactoryGirl.create(:conference, user_id: user.id) }
    subject { FactoryGirl.build(:feedback, user_id: nil, conference_id: conference.id) }

    it { should be_valid }

    it "should send email to conference creator" do
      subject.read!
      ActionMailer::Base.deliveries.should_not be_empty
    end
  end

  context "when feedback has user_id" do
    subject { FactoryGirl.build(:feedback, email: nil, user_id: user.id) }
    before { subject.valid? }

    it "should not require email" do
      subject.errors[:email].should be_empty
    end

    it "should return email of customer" do
      subject.customer_email.should be_eql(user.email)
    end
  end

  context "when feedback has email" do
    subject { FactoryGirl.build(:feedback, user_id: nil) }
    before { subject.valid? }

    it "should not require user_id" do
      subject.errors[:user_id].should be_empty
    end

    it "should return email of customer" do
      subject.customer_email.should be_eql(subject.email)
    end

    context "when email has invalid format" do
      subject { FactoryGirl.build(:feedback, user_id: nil, email: "sad@#123.asd") }

      it { should_not be_valid }
    end
  end

  context "when feedback has empty data fields" do
    subject { FactoryGirl.build(:feedback, title: nil, body: nil) }
    before { subject.valid? }

    it "should validate title" do
      subject.errors[:title].should_not be_empty
    end

    it "should validate body" do
      subject.errors[:body].should_not be_empty
    end
  end

end
