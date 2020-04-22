require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get root" do
    get root_path
    assert_response :success
    assert_select "title", "HSPortal"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | HSPortal"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | HSPortal"
  end
end
