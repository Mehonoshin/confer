require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ConferencesHelper. For example:
#
# describe ConferencesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
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


end
