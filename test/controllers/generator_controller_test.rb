require "test_helper"

class GeneratorControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get generator_new_url
    assert_response :success
  end

  test "should get create" do
    get generator_create_url
    assert_response :success
  end
end
