# Bury

[![Test](https://github.com/patorash/bury/actions/workflows/test.yml/badge.svg)](https://github.com/patorash/bury/actions/workflows/test.yml)

Bury is a library for extending the Hash class. `Hash#bury` method is the opposite of the `Hash#dig` method.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bury'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install bury

## Usage

```ruby
{}.bury([:a, :b, :c], 1) # => {a:{b:{c: 1}}}
{a: {d: 2}}.bury([:a, :b, :c], 1) # => {a:{d: 2,b:{c: 1}}
{a: {b: {d:1}}}.bury([:a, :b, :c], 1) # => {a:{b:{c: 1, d: 1}}
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/patorash/bury. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/patorash/bury/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Bury project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/patorash/bury/blob/master/CODE_OF_CONDUCT.md).
