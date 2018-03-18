require "rails_helper"
require "generators/admin_generator"

describe AdminGenerator, type: :generator do
  context "with valid admin credentials" do
    before(:each) do
      admin = FactoryBot.build(:user)

      run_generator [
        "admin",
        "--email", admin.email,
        "--username", admin.username,
        "--password", admin.password
      ]
    end

    it "creates a user admin" do
      created_admin = User.last
      expect(created_admin).not_to be_nil
      expect(created_admin.is_admin).to be true
    end
  end

  context "with invalid admin credentials" do
    before(:each) do
      admin = FactoryBot.build(:user)

      run_generator [
        "admin",
        "--email", admin.email,
        "--username", admin.username,
        "--password", "aaa"
      ]
    end

    it "creates a user admin" do
      expect(User.count).to eq(0)
    end
  end
end
