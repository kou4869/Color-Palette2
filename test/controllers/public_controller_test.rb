require "test_helper"

class PublicControllerTest < ActionDispatch::IntegrationTest
  test "should get tags" do
    get public_tags_url
    assert_response :success
  end
end
