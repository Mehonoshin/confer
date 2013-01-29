require 'spec_helper'

describe Participant do
  context "regular paticipant" do
    let(:user) { create(:user) }
    subject { FactoryGirl.create(:participant, user_id: user.id) }

    it { should be_valid }

    it "should have no reports" do
      subject.reports.should be_empty
    end

    it "should notify user when his participation is approved" do
      subject.approve!
      subject.approved?.should be_true
      ActionMailer::Base.deliveries.should_not be_empty
    end
  end

  context "invalid object" do
    subject { FactoryGirl.build(:participant, user_id: nil, conference_id: nil) }
    before { subject.valid? }

    it "should not be valid without user_id" do
      subject.errors[:user_id].should_not be_empty
    end

    it "should not be valid without conference_id" do
      subject.errors[:conference_id].should_not be_empty
    end
  end

  context "when has report" do
    subject { FactoryGirl.create(:participant) }
    let(:report) { FactoryGirl.create(:report, participant_id: subject.id) }

    it "should have unapproved states" do
      subject.new?.should be_true
      report.pending?.should be_true
    end

    it "should approve user after report approval" do
      report.approve!
      report.approved?.should be_true
      report.participant.approved?.should be_true
    end
  end

end
