require 'spec_helper'

describe Conference do
  let(:owner) { FactoryGirl.create(:user) }
  subject { FactoryGirl.create(:conference, user_id: owner.id) }

  it "should notify when guests are limited" do
    subject.guests_limit?.should be_true
  end

  it "should notify when guests limit is reached" do
    guests_limit = subject.max_guests
    subject.guests << FactoryGirl.create(:user)
    subject.guests_limit_reached?.should be_true
  end

  context "when guests number is unlimited" do
    subject { FactoryGirl.create(:conference, user_id: owner.id, max_guests: nil) }

    it "should notify that guests are unlimited" do
      subject.guests_limit?.should be_false
    end
  end

  context "when new" do
    it { should be_valid }

    it "should have no guests" do
      subject.guests.should be_empty
    end

    it "should be in pending state" do
      subject.state.should be_eql("pending")
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

    it "should return notification email" do
      subject.notification_email.should be_eql(subject.user.email)
    end

    it "should return notify email when present" do
      conf = FactoryGirl.create(:conference, notify_email: "admin@service.com")
      conf.notification_email.should be_eql(conf.notify_email)
    end

    it "should not allow incorrect domain" do
      conf = FactoryGirl.build(:conference, domain: "sad21=@@#!")
      conf.should_not be_valid
    end

    it "should pass correct domain" do
      conf = FactoryGirl.build(:conference, domain: "sad-21")
      conf.should be_valid
    end

    it "should allow to check enabled site modules" do
      subject.module_enabled?("news").should be_true
      subject.module_enabled?("personal_page").should be_false
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

    it "should force domain name to downcase" do
      conf = FactoryGirl.create(:conference, domain: "WA2013")
      conf.domain.should be_eql("wa2013")
    end

    it "should validate notify email and public email format" do
      conf = FactoryGirl.build(:conference, notify_email: "invalid@@$asd", public_email: "invalid_email")
      conf.valid?
      conf.errors[:notify_email].should_not be_empty
      conf.errors[:public_email].should_not be_empty
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

    context "when no registration deadline" do
      subject { FactoryGirl.build(:conference, start_date: 1.month.ago, end_date: 1.day.ago) }

      it "should not accepted participants by end_date" do
        subject.registration_open?.should_not be_true
      end
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

  context "when conference approved" do
    before(:each) do
      subject.approve!
    end

    it "should have approved state" do
      subject.state.should be_eql("approved")
    end

    it "should send email to creator" do
      ActionMailer::Base.deliveries.should_not be_empty
    end
  end

end
