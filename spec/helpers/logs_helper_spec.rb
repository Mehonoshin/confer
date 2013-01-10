# encoding: utf-8
require 'spec_helper'

describe LogsHelper do

  describe "auditable_name" do
    context "when auditable is present" do
      let(:user) { FactoryGirl.create(:user) }
      before { user.update_attributes(FactoryGirl.attributes_for(:user)) }

      it "should return link to admin model path" do
        auditable_name(user.audits.last).should include(user.email)
      end
    end

    context "when auditable objet does not exist" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        user.update_attributes(FactoryGirl.attributes_for(:user))
      end

      it "should return model name" do
        audit = user.audits.last
        user.destroy
        auditable_name(audit).should be_eql("Пользователь")
      end
    end
  end

  describe "auditable_title" do
    context "when aditable is conference" do
      let(:conference) { FactoryGirl.create(:conference) }
      before { conference.update_attributes(FactoryGirl.attributes_for(:conference)) }

      it "should return conference name" do
        auditable = conference.audits.last.auditable
        auditable_title(auditable).should be_eql(conference.name)
      end

    end

    context "when auditable is user" do
      let(:user) { FactoryGirl.create(:user) }
      before { user.update_attributes(FactoryGirl.attributes_for(:user)) }

      it "should return user email" do
        auditable = user.audits.last.auditable
        auditable_title(auditable).should be_eql(user.email)
      end
    end
  end

  describe "audit_actor" do
    context "when audit user is present", pending: "Dont know how to pass user_id to audit" do
      let(:user) { FactoryGirl.create(:user) }
      before { user.update_attributes(FactoryGirl.attributes_for(:user)) }

      it "should return admin user link" do
        audit = user.audits.last
        audit_actor(audit).should include("<a")
        audit_actor(audit).should include(user.email)
      end
    end

    context "when audit has no user" do
      let(:user) { FactoryGirl.create(:user) }
      before { user.update_attributes(FactoryGirl.attributes_for(:user)) }

      it "should return nothing" do
        audit = user.audits.last
        user.destroy
        audit_actor(audit).should be_nil
      end
    end
  end

  describe "audit_action", pending: "not implemented yet" do

  end

end
