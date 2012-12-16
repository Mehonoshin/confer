require 'spec_helper'

describe Conference do

  context "when new" do
    subject { FactoryGirl.create(:conference) }

    it { should be_valid }

    it "should have no guests" do
      subject.guests.should be_empty
    end
  end

  context "when empty fields" do
    subject { FactoryGirl.build(:conference, name: "", start_date: nil, end_date: nil) }

    before do
      subject.valid?
    end

    it "should require name" do
      subject.errors[:name].should_not be_empty
    end

    it "should require start date" do
      subject.errors[:start_date].should_not be_empty
    end

    it "should require end date" do
      subject.errors[:end_date].should_not be_empty
    end
  end

end
