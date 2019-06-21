require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "Task App"
  end
  
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Task App"
  end
    
  test "should get help" do
    get help_url
    assert_response :success
    assert_select "title", "Help | Task App"
  end
  
  test "should get contact" do
    get contact_url
    assert_response :success
    assert_select "title", "Contact | Task App"
  end
end
