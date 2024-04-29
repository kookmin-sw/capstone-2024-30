require "test_helper"

class ChatsPollingControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get chats_polling_create_url
    assert_response :success
  end
end
