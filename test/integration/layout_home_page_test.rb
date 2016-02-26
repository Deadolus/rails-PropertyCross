require 'test_helper'

class LayoutHomePageTest < ActionDispatch::IntegrationTest
    def setup
        get root_path
    end
    test "home link present" do
        assert_select 'a[href=?]', root_path,  text: "PropertyCross"
    end
    test "Search link present" do
        assert_select "form", count: 1
        assert_select "form > input", count: 4
    end
    test "Favourites present" do
        assert_select 'a[href=?]', favourites_path,  text: "Favourites"
    end
end
