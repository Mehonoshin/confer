require 'spec_helper'

describe Page do
  let(:conference) { create(:conference) }
  subject { create(:page, conference_id: conference.id) }

  describe "validations" do
    subject { build(:page, conference_id: conference.id) }
    let(:another_conference) { create(:conference) }

    it { should_not allow_value("me.com.ru").for(:permalink) }
    it { should allow_value("me-com").for(:permalink) }

    context "when conference has a page with the same permalink" do
      before { create(:page, conference_id: conference.id) }

      it { should_not be_valid}
    end

    context "when other conference has the same page permalink" do
      before { create(:page, conference_id: another_conference.id) }

      it { should be_valid }
    end

    context "when body is empty" do
      subject { build(:page, conference_id: conference.id, body: nil) }

      it { should_not be_valid }
    end

  end

  it "to_param should return permalink" do
    subject.to_param.should be_eql subject.permalink
  end

end
