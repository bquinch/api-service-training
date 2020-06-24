require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  context "when first name is present" do
    it "should be valid" do
      expect(user.first_name).to eq("George")
      expect(user).to be_valid
    end
  end

  context "when first name is nil" do
    it "shouldn't be valid" do
      user.first_name = nil
      expect(user).to_not be_valid
    end
  end

  context "when last name is present" do
    it "should be valid" do
      expect(user.last_name).to eq("Abitbol")
      expect(user).to be_valid
    end
  end

  context "when last name is nil" do
    it "shouldn't be valid" do
      user.last_name = nil
      expect(user).to_not be_valid
    end
  end
end
