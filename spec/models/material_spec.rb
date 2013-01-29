require 'spec_helper'

describe Material do
  context "with correct attributes" do
    subject { build(:material) }
    it { should be_valid }
  end

  context "with empty attributes" do
    subject { build(:material, name: nil, file: nil, user_id: nil) }
    it { should validate_presence_of :file }
    it { should validate_presence_of :name }
    it { should validate_presence_of :conference_id }
    it { should validate_presence_of :user_id }
  end
end
