require 'nestoria'


class LayoutHelperTest < ActionDispatch::IntegrationTest
    def setup
        @nestoria = MyNestoria.new
    end
    
    #test private getProperties method
  test "will get places" do
      #properties = @nestoria.getProperties("London")
      properties = @nestoria.send(:get_listings, "London")
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


end
