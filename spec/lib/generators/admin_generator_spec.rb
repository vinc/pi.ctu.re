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
      expect(created_admin.admin?).to be true
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

  context "with attributes from stdin" do
    before(:each) do
      admin = FactoryBot.build(:user)

      fake_stdin(admin.slice(:email, :username, :password).values) do
        run_generator ["admin"]
      end
    end

    it "creates a user admin" do
      created_admin = User.last
      expect(created_admin).not_to be_nil
      expect(created_admin.admin?).to be true
    end
  end

  private

  def fake_stdin(*args)
    $stdin = StringIO.new
    $stdin.puts(args.shift) until args.empty?
    $stdin.rewind
    yield
  ensure
    $stdin = STDIN
  end
end
