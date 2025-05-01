require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "Invalid User record should not be saved" do
    user = User.new

    assert_not user.save
  end

  test "Valid User record should be saved" do
    user = User.new(email_address: "example@gmail.com", password: "supersecurepassword123", password_confirmation: "supersecurepassword123")

    assert user.save
  end
end
