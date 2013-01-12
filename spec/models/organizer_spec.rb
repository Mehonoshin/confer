require 'spec_helper'

describe Organizer do
  context "when new" do
    subject { FactoryGirl.create(:organizer) }

    it { should be_valid }
  end

  context "when created by email" do
    let(:user) { FactoryGirl.create(:user) }
    subject { FactoryGirl.create(:organizer_by_email, email: user.email) }

    it "should have user id" do
      subject.user_id.should be_eql(user.id)
    end
  end

  context "with empty attrs" do
    subject { FactoryGirl.build(:organizer, user_id: nil, conference_id: nil, role: "") }
    before { subject.valid? }

    it "should require user_id" do
      subject.errors[:user_id].should_not be_empty
    end

    it "should require conference_id" do
      subject.errors[:conference_id].should_not be_empty
    end

    it "should require role" do
      subject.errors[:role].should_not be_empty
    end
  end

end
