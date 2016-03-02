
require 'test_helper'

class FavouriteTest < ActiveSupport::TestCase
    def setup 
        @session = {:favourites => []}
        @favourites = Favourite.new(@session)
    end
    test "delete invalid favourite with id" do
        assert_not @favourites.delete_favourite_with_id(0)
    end
    test "delete invalid favourite with title" do
        assert_not @favourites.delete_favourite_with_title(0)
    end
    test "create favourite" do
        @favourites.create_favourite({"title" => "Test"})
        assert 1, @session[:favourites].count
    end
    test "delete valid favourite with id" do
        @favourites.create_favourite({"title" => "Test"})
        assert 1, @session[:favourites].count
        assert @favourites.delete_favourite_with_id(0)
        assert 0, @session[:favourites].count
    end
    test "delete valid favourite with title" do
        @favourites.create_favourite({"title" => "Test"})
        assert 1, @session[:favourites].count
        assert @favourites.delete_favourite_with_title("Test")
        assert 0, @session[:favourites].count
    end
end
