require 'spec_helper'

describe Conference do

  context "when new" do
    let(:owner) { FactoryGirl.create(:user) }
    subject { FactoryGirl.create(:conference, user_id: owner.id) }

    it { should be_valid }

    it "should have no guests" do
      subject.guests.should be_empty
    end

    it "should have only one stuff" do
      subject.stuff.size.should be_eql(1)
    end

    it "should have the only user its creator" do
      subject.stuff.last.should be_eql(owner)
    end

    it "creator should have owner role" do
      subject.organizers.last.role.should be_eql("owner")
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
