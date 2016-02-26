# This has to come first
require 'simplecov'
SimpleCov.start
require_relative "./support/rails"

# Load everything else from test/support
Dir[File.expand_path("../support/**/*.rb", __FILE__)].each { |rb| require(rb) }
class ActiveSupport::TestCase
    fixtures :all 

    #include our own ApplicationHelpers
    include ApplicationHelper
    def search_for_properties(location)
        post listings_path,  search: { "location" => location }
        follow_redirect!
    end
end

