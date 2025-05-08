require "test_helper"

class RegistrationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get registration_index_path
    assert_response :success
    assert_select "form" 
  end

  test "should create user with valid parameters" do
    post registration_create_path, params: {
      user: {
        email_address: "test@example.com",
        password: "password123",
        password_confirmation: "password123"
      }
    }

    assert_redirected_to new_session_path
    assert_equal "Your account was created successfully", flash[:success]
    assert User.find_by(email_address: "test@example.com")
  end

  test "should not create user with invalid parameters" do
    post registration_create_path, params: {
      user: {
        email_address: "invalid-email",
        password: "123",
        password_confirmation: "456"
      }
    }

    assert_response :not_acceptable 
    assert flash[:errors].present?
  end
end
