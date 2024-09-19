require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
 test "redirects to feed after successful sign up" do
   get sign_up_path
   assert_response :ok

    assert_difference ["User.count", "Organization.count"], 1 do
      post sign_up_path, params: {
        user: {
          name: "John",
          email: "john@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
   end

   assert_redirected_to root_path
   follow_redirect!

   assert_select ".notification",
     text: I18n.t("users.create.welcome", name: "John")
 end

 test "renders errors if input data is invalid" do
    get sign_up_path
    assert_response :ok

    assert_no_difference ["User.count", "Organization.count"] do
      post sign_up_path, params: {
        user: {
          name: "John",
          email: "john@example.com",
          password: "pass"
        }
      }
    end
    assert_response :unprocessable_entity
    assert_select "p.text-red-500.text-sm",
      text: I18n.t("activerecord.errors.models.user.attributes.password.too_short")
    end
  test "renders errors if password and password_confirmation don't match" do
    get sign_up_path
    assert_response :ok
    assert_no_difference ["User.count", "Organization.count"] do
      post sign_up_path, params: {
        user: {
            name: "John",
            email: "john@example.com",
            password: "password",
          password_confirmation: "different_password"
          }
        }
      end
      assert_response :unprocessable_entity
      assert_select "p.text-red-500.text-sm",
      text: I18n.t("activerecord.errors.models.user.attributes.password_confirmation.confirmation")
    end
end
