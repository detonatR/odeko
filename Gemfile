source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "graphql"
gem "rails", "~> 7.0.5"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

gem "bootsnap", require: false

gem "rack-cors"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "factory_bot_rails"
  gem "rspec-rails"
end

group :test do
  gem "rspec-graphql_matchers"
  gem "shoulda-matchers"
end
