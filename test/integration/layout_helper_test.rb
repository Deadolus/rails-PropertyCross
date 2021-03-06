require "test_helper"

class LayoutHelperTest < ActionDispatch::IntegrationTest
  test "rendered page contains both base and application layouts" do
    visit("/")
    assert(page.has_selector?("html>head+body"))
    assert(page.has_selector?("body p"))
    assert_match(/Search for Properties/, page.title)
  end
  test "will be redirected on invalid page request" do
    visit("/0/")
    assert_match(/Invalid request/, page.body)
  end
end
