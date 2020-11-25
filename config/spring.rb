Spring.watch(
  ".ruby-version",
  ".rbenv-vars",
  "tmp/restart.txt",
  "tmp/caching-dev.txt"
)
if ENV['RAILS_ENV'] == 'test'
  require 'simplecov'
  SimpleCov.start 'rails'
end