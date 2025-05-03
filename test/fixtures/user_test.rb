require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "fixture users are valid" do
    assert users(:one).valid?
    assert users(:two).valid?
  end

  test "authenticates with correct password" do
    user = users(:one)
    assert user.authenticate("password")
  end

  test "does not authenticate with incorrect password" do
    user = users(:one)
    refute user.authenticate("wrongpassword")
  end

  test "email_address is normalized (downcased and stripped)" do
    user = User.create!(email_address: "  TEST@Example.COM  ", password: "secret", password_confirmation: "secret")
    assert_equal "test@example.com", user.email_address
  end

  test "has many sessions and destroys them with user" do
    user = users(:one)
    session = user.sessions.create!
    assert_difference("Session.count", -1) do
      user.destroy
    end
  end

  test "email_address is unique (DB constraint)" do
    User.create!(email_address: "unique@example.com", password: "secret", password_confirmation: "secret")

    assert_raises ActiveRecord::RecordNotUnique do
      User.create!(email_address: "unique@example.com", password: "secret", password_confirmation: "secret")
    end
  end
end
