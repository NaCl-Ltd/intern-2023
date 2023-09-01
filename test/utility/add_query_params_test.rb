require 'test_helper'

class AddQueryParamsTest < ActiveSupport::TestCase
  test "should add locale=en parameter to URL" do
    url = "http://example.com"
    expected_url = "http://example.com?locale=en"
    assert_equal expected_url, add_query_params(url)
  end

  test "should add locale=en parameter to URL with existing query parameters" do
    url = "http://example.com?foo=bar"
    expected_url = "http://example.com?foo=bar&locale=en"
    assert_equal expected_url, add_query_params(url)
  end
end