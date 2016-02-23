require 'test_helper'

class HousesControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, :listing_location => "Essex", :id => 0
    assert_response :success
  end

  test "show should equal listing" do
        Listing.get_properties("London").each_with_index do |house, index|
    get :show, :listing_location => "London", :id => index
    assert_select "div#house-title", text: house.title
        end

  end

end
