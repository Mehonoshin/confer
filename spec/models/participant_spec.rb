require 'spec_helper'

describe Participant do
  context "regular paticipant" do
    subject { FactoryGirl.create(:participant) }

    it { should be_valid }
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
end
