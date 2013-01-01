require 'spec_helper'

describe Report do

  context "when new" do
    subject { FactoryGirl.create(:report) }

    it "should be valid" do
      subject.should be_valid
    end

    it "should be in pending state" do
      subject.state.should be_eql("pending")
    end
  end

  context "when fields are empty" do
    subject { FactoryGirl.build(:report, title: nil, description: nil, participant_id: nil, conference_id: nil) }

    before(:each) do
      subject.valid?
    end

    it "should not be valid" do
      subject.should_not be_valid
    end

    it "should require conference_id" do
      subject.errors[:conference_id].should_not be_empty
    end

    it "should require title" do
      subject.errors[:title].should_not be_empty
    end

    it "should require description" do
      subject.errors[:description].should_not be_empty
    end

  end
end
