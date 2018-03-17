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
    # expensive method that puts out attributes in pretty format
    def list_attrs
      longest_key_length = attributes.keys.max { |a, b| a.to_s.length <=> b.to_s.length }.length
      puts
      attributes.sort.to_h.each do |k, v|
        spaces_offset = longest_key_length - k.to_s.length
        spaces = ' ' * spaces_offset
        puts "#{k}#{spaces}\t#{v == nil ? 'nil' : v}"
      end
    end
  end

end

```

Then your debug_methods (like `#list_attrs` above) will only be allowed in the
development environment.

```
$ RAILS_ENV="development" rails console
>> person = Person.new(name: "Jake", age: "30")
>> person.list_attrs

age             30
created_at	nil
id        	nil
name      	Jake
updated_at	nil

$ RAILS_ENV="test" rails console
>> person = Person.new(name: "Jake", age: "30")
>> person.list_attrs
NoMethodError (undefined method `list_attrs' for #<Thing id: nil, name: "Jake",
age: 30, created_at: nil, updated_at: nil>)
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
