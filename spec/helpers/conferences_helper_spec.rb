require 'spec_helper'

describe ConferencesHelper do

  describe "human_date_with_time" do
    context "when date is empty" do
      it "should return nil" do
        human_date_with_time(nil).should be_nil
      end
    end
    context "when date is present" do
      it "should format it with time" do
        human_date_with_time("2012-12-22 02:07:05 +0400".to_datetime).to_s.should be_eql("22.12.2012 02:07")
      end
    end
  end

  describe "human_date" do
    context "when date is empty" do
      it "should return nil" do
        human_date(nil).should be_nil
      end
    end
    context "when date is present" do
      it "should format it" do
        human_date("2012-12-22 02:07:05 +0400".to_datetime).to_s.should be_eql("22.12.2012")
      end
    end
  end

  describe "conference_site_link" do
    subject { FactoryGirl.create(:conference) }

    it "should return plain link if no block passed" do
      helper.conference_site_link(subject).should include(subject.name)
    end

    it "should execute block passed to helper" do
      helper.conference_site_link(subject) do
        "<h3>#{subject.name}</h3>"
      end.should include("h3")
    end
  end
end
