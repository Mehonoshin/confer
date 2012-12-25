# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'spec_helper'

describe User do
  subject { FactoryGirl.create(:user) }

  context "when new" do
    it { should be_valid }

    it "should have no participations" do
      subject.participations.should be_empty
    end

    it "should have no organized events" do
      subject.organized.should be_empty
    end

    it "should have empty address" do
      subject.address.should be_nil
    end

  end
end
