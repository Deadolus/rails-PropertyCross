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
        assert_redirected_to favourites_path
        follow_redirect!
        assert_not flash.empty?
        assert_select ".house-title", count: 0
    end

    test "should be able to delete favourites with Ajax" do
        get favourite_path(0)
        assert_select "#house-title", count: 1
        xhr :delete, favourite_path(0)
        #With ajay there's only a reload with template destroy.js.erb
        assert_template 'favourites/destroy'
        get favourites_path
        assert_select ".house-title", count: 0
    end
    
    test "can not delete non-existing favourite with http" do
        get favourites_path
        assert_select ".house-title", count: 1
        delete favourite_path(1)
        assert_redirected_to root_url
        follow_redirect!
        assert_not flash.empty?
        assert_select ".house-title", count: 0
    end
    test "can not delete non-existing favourite with ajax" do
        get favourites_path
        assert_select ".house-title", count: 1
        xhr :delete, favourite_path(1)
        assert_match "Could not delete", response.body
    end
end
