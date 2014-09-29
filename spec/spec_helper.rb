require 'simplecov'

require 'rspec'

Dir[File.dirname(__FILE__) + '/support/*.rb'].each { |file| require file }
RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

include Bowlr
