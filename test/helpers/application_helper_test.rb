require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,         "Task App"
    assert_equal full_title("Help"), "Help | Task App"
  end
end