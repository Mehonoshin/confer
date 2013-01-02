#encoding: utf-8
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

  context "when address is specified" do
    subject { FactoryGirl.create(:user, address: "Russia, Voronezh") }

    it "should save city and country" do
      subject.country.should be_eql("Россия")
      subject.city.should be_eql("Воронеж")
    end

    it "should change city" do
      subject.update_attributes(address: "Россия, Москва")
      subject.country.should be_eql("Россия")
      subject.city.should be_eql("Москва")
    end

    context "when address is empty" do
      it "should not change city and country" do
        subject.update_attributes(address: "")
        subject.country.should be_eql("Россия")
        subject.city.should be_eql("Воронеж")
      end

      it "should not change city and country" do
        subject.update_attributes(address: " ,")
        subject.country.should be_eql("Россия")
        subject.city.should be_eql("Воронеж")
      end
    end
  end

  context "when owns conference" do
    subject { FactoryGirl.create(:user) }
    let(:conference) { FactoryGirl.create(:conference, user_id: subject.id) }

    it "should not be global admin" do
      subject.admin?.should_not be_true
    end

    it "should be project admin" do
      subject.admin?(conference).should be_true
    end
  end

  context "when doesnt own conference" do
    subject { FactoryGirl.create(:user) }

    it "should not be admin" do
      subject.admin?.should_not be_true
    end
  end

end
