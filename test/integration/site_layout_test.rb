require "test_helper"
require_relative "../../utility/add_query_params.rb"

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", add_query_params(root_path), count: 2
    assert_select "a[href=?]", add_query_params(help_path)
    assert_select "a[href=?]", add_query_params(about_path)
    assert_select "a[href=?]", add_query_params(contact_path)
  end
end
