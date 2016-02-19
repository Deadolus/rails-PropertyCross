require 'test_helper'

class ListingsControllerTest < ActionController::TestCase
    test "should get new" do
        get :new
        assert_response :success
    end

    test "should get show" do
        get :show, location: "London"
        assert_response :success
        assert_select '.property', count: 20
    end

    test "should be able to create search" do
        post :create, search: { location: "london"}
        assert_redirected_to listing_url "london"
    end

    test "should be redirected on invalid search" do
        post :create, nosense: "test"
        assert_redirected_to root_url
        post :create, search: { location: "   "}
        assert_redirected_to root_url

    end
end
