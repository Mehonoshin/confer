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
    subject do
      VCR.use_cassette("user/creating_voronezh_user") do
        FactoryGirl.create(:user, address: "Russia, Voronezh")
      end
    end

    it "should save city and country" do
      subject.country.should be_eql("Россия")
      subject.city.should be_eql("Воронеж")
    end

    it "should change city" do
      VCR.use_cassette("user/update_address_to_moscow") do
        subject.update_attributes(address: "Россия, Москва")
        subject.country.should be_eql("Россия")
        subject.city.should be_eql("Москва")
      end
    end

    context "when address is empty" do
      it "should not change city and country" do
        VCR.use_cassette("user/request_empty_address") do
          subject.update_attributes(address: "")
          subject.country.should be_eql("Россия")
          subject.city.should be_eql("Воронеж")
        end
      end

      it "should not change city and country" do
        VCR.use_cassette("user/request_invalid_address") do
          subject.update_attributes(address: " ,")
          subject.country.should be_eql("Россия")
          subject.city.should be_eql("Воронеж")
        end
      end
    end
  end

  context "when owns conference" do
    let(:conference) { FactoryGirl.create(:conference, user_id: subject.id) }

    it "should not be global admin" do
      subject.admin?.should_not be_true
    end

    it "should be project admin" do
      subject.admin?(conference).should be_true
    end
  end

  context "when doesnt own conference" do
    it "should not be admin" do
      subject.admin?.should_not be_true
    end
  end

  context "when participates in conference" do
    let(:conference) { FactoryGirl.create(:conference) }
    before { FactoryGirl.create(:participant, user_id: subject.id, conference_id: conference.id) }

    it "should tell that user already participates" do
      subject.participates?(conference).should be_true
    end
  end

  context "when doesnt participate in conference" do
    let(:conference) { FactoryGirl.create(:conference) }

    it "should tell that user is not participate" do
      subject.participates?(conference).should be_false
    end
  end


end
