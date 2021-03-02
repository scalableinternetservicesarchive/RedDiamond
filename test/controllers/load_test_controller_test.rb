require "test_helper"

class LoadTestControllerTest < ActionDispatch::IntegrationTest
  test "sign_in_as_new_user creates new users" do
    assert_difference 'User.count' do
      get load_test_sign_in_as_new_user_path
    end
  end
end
