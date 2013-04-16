require 'simplecov'
SimpleCov.start('rails') do
  add_filter "/annotate/"
  add_filter "app/models/ckeditor/"
  add_filter "app/uploaders/"
  add_filter "app/helpers"
end if ENV['COVERAGE']

if ENV["TRAVIS"]
  require 'coveralls'
  Coveralls.wear! 'rails'
end

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  #fixtures :all
  include FactoryGirl::Syntax::Methods
  include AuthHelper
  # Add more helper methods to be used by all tests here...
end

def fixture_file_upload(path, mime_type = nil, binary = false)
  fixture_path = ActionController::TestCase.fixture_path
  Rack::Test::UploadedFile.new("#{fixture_path}#{path}", mime_type, binary)
end
