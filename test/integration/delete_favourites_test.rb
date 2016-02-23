require 'test_helper'

class DeleteFavouritesTest < ActionDispatch::IntegrationTest
    def setup 
        @house = {title:  "Test", price: "666", thumb_url: "test_thumb_url", img_url: "test_img_url", bathroom_number: 123, bedroom_number: 456, summary: "Test summary"}
        post_via_redirect favourites_path, favourite: @house #{ title: "Test", price: "666" }
    end

    test "should be able to delete favourites" do
        get favourites_path
        assert_select ".house-title", count: 1
        delete favourite_path(0)
        get favourites_path
        assert_select ".house-title", count: 0
    end
end
