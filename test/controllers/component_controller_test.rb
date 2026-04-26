require "test_helper"

class ComponentControllerTest < ActionDispatch::IntegrationTest
  test "should get nav" do
    get component_nav_url
    assert_response :success
  end
end
