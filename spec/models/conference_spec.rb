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

    it "should require unique domain" do
      existing_domain = subject.domain
      new_conf = FactoryGirl.build(:conference, domain: existing_domain)
      new_conf.should_not be_valid
    end

    it "should require start date be less than end date" do
      conf = FactoryGirl.build(:conference, start_date: Time.now, end_date: 1.day.ago)
      conf.valid?
      conf.errors[:start_date].should_not be_empty
    end

    it "should require registration date be less than end date" do
      conf = FactoryGirl.build(:conference, registrable_until: Time.now, end_date: 1.day.ago)
      conf.valid?
      conf.errors[:registrable_until].should_not be_empty
    end
  end

  context "adding participants" do
    subject { FactoryGirl.create(:conference, start_date: Time.now, end_date: 1.month.from_now, registrable_until: 2.weeks.from_now) }

    it "should keep registration open" do
      subject.registration_open?.should be_true
    end

    it "should not accepted participants" do
      conf = FactoryGirl.create(:conference, start_date: Time.now, end_date: 1.month.from_now, registrable_until: 1.day.ago)
      conf.registration_open?.should_not be_true
    end
  end

  context "when empty fields" do
    subject { FactoryGirl.build(:conference, name: "", domain: "", user_id: nil, start_date: nil, end_date: nil) }

    before do
      subject.valid?
    end

    it "should require name" do
      subject.errors[:name].should_not be_empty
    end

    it "should require user_id" do
      subject.errors[:user_id].should_not be_empty
    end

    it "should require domain" do
      subject.errors[:domain].should_not be_empty
    end

    it "should require start date" do
      subject.errors[:start_date].should_not be_empty
    end

    it "should require end date" do
      subject.errors[:end_date].should_not be_empty
    end
  end

end
