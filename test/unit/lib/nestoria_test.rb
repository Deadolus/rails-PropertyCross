require 'nestoria'


class LayoutHelperTest < ActionDispatch::IntegrationTest
    def setup
        @nestoria = MyNestoria.new
    end
    
    #test private getProperties method
  test "will get places" do
      #properties = @nestoria.getProperties("London")
      properties = @nestoria.send(:get_listings, "London").first
      assert_equal 20, properties.count
      firstproperty = properties.first
      #Test some of the keys
      assert firstproperty.has_key? :price
      assert firstproperty.has_key? :title
      assert firstproperty.has_key? :img_url
      #test NestoriaListing class
      #Create NestoriaListing from firstproperty, will only contain interesting keys
      listing  = PropertyListing.new firstproperty
      assert_equal listing.price, firstproperty[:price]
      assert_equal listing.title, firstproperty[:title]
      assert_equal listing.img_url, firstproperty[:img_url]
      listing.img_url = "fake"
      listing.price = "-10"
      assert_not_equal listing.img_url, firstproperty[:img_url]
      assert_not_equal listing.price, firstproperty[:price]
  end

  test "will get a total properties number" do
      total_number = @nestoria.send(:get_listings, "London").second
      #There are propably always more than 100 listings for london
      assert_operator total_number, :>, 100
  end

  test "will get location based search" do
      properties = @nestoria.send(:get_location_listings, 51.6, -3.4).first
      assert_equal 20, properties.count
  end


end
