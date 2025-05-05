require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "fixture users are valid" do
    u1 = users(:one)
    u2 = users(:two)

    u1.save
    u2.save

    assert u1.persisted?
    assert u2.persisted?
  end

  test "authenticates with correct password" do
    user = users(:one)
    assert user.authenticate("password123")
  end

  test "does not authenticate with incorrect password" do
    user = users(:one)
    refute user.authenticate("wrongpassword")
  end

  test "email_address is normalized (downcased and stripped)" do
    user = User.create!(email_address: "  TEST@Example.COM  ", password: "secret1234", password_confirmation: "secret1234")
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
    User.create!(email_address: "unique@example.com", password: "secret1234", password_confirmation: "secret1234")

    assert_raises(ActiveRecord::RecordInvalid) do
      User.create!(email_address: "unique@example.com", password: "secret1234", password_confirmation: "secret1234")
    end
  end

  test "Invalid User record should not be saved" do
    user = User.new

    assert_not user.save
  end

  test "Valid User record should be saved" do
    user = User.new(email_address: "example@gmail.com", password: "secret12", password_confirmation: "secret12")

    assert user.save
  end
end
