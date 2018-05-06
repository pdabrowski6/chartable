require 'active_record'
require 'rspec'
require 'factory_bot_rails'
require 'timecop'
require 'chartable'
require 'database_cleaner'

load File.dirname(__FILE__) + '/support/database.rb'

FactoryBot.define do
  factory :user do
  end
end

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with :deletion
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
