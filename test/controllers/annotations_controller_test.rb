require "test_helper"

class AnnotationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @annotation = annotations(:one)
  end

  test "should show annotation" do
    get annotation_url(@annotation)
    assert_response :success
  end

end
