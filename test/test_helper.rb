ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require "minitest/rails"
require "minitest/reporters"  # for Colorized output
require 'simplecov'

SimpleCov.start
#  For colorful output!
Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter
)

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors) # causes out of order output.

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def setup
    # Once you have enabled test mode, all requests
    # to OmniAuth will be short circuited to use the mock authentication hash.
    # A request to /auth/provider will redirect immediately to /auth/provider/callback.
    OmniAuth.config.test_mode = true
  end

  def mock_auth_hash(merchant)
    # takes merchant data and mocks auth_hash for testing github login
    return {
        provider: merchant.provider,
        uid: merchant.uid,
        info: {
            email: merchant.email,
            nickname: merchant.name
        }
    }
  end

  def perform_login(merchant = nil)
    merchant ||= Merchant.first

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(merchant))
    get create_merchant_path
    merchant = Merchant.find_by(uid: merchant.uid)
    return merchant
  end

end

