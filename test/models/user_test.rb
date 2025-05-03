require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "Invalid User record should not be saved" do
    user = User.new

    assert_not user.save
  end

  test "Valid User record should be saved" do
    user = User.new(email_address: "example@gmail.com", password: "secret12", password_confirmation: "secret12")

    assert user.save
  end
end
