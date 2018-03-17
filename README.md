# DebugMethods

DebugMethods is a module that lets you define environment specific methods in
your Ruby on Rails app so you can build yourself useful inspection utilities in
development without adding weight to your classes in production.

## Installation

Add this line to your Rails application's Gemfile:

```ruby
gem 'debug_methods'
```

And then execute:

    $ bundle

## Usage

Just include DebugMethods in any class and wrap your debug methods in a block
being passed to #debug_methods.

```ruby
class Thing < ApplicationRecord
  include DebugMethods

  debug_methods do
    def sorted_attrs
      attributes.sort.to_h
    end
  end

end

```

DebugMethods defaults to only including methods in the :development environment.
To configure which environments debug methods should be available in, add an
initializer. Add the file `config/initializers/debug_methods.rb` and include the
following:

```ruby
DebugMethods.configure do |config|
  config.environments << :test
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/debug_methods.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
