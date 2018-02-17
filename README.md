# JSON::Lisp

Execute lisp-like s-expressions written in JSON.

The aim of JSON-Lisp is to allow for an executable code format that is simple and portable, as well as easy to parse and execute in a controlled, sandboxed environment. This allows it to be stored in a database, sent over an HTTP connection, collected from user input, and executed on either a client or a server's machine.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'json-lisp'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install json-lisp

## Usage

```ruby
constants = {
  "a" => 5,
  "b" => 7,
  "+" => -> (a, b) { a + b },
  "-" => -> (a, b) { a - b }
}

json_lisp_env = JSON::Lisp::Env.new(constants)

json_lisp_env.evaluate(["+", "a", "b"])           #=> 12
json_lisp_env.evaluate(["-", "a", 3])             #=> 2
json_lisp_env.evaluate(["+", 2, "b"])             #=> 9
json_lisp_env.evaluate(["+", "a", ["-", "b", 2]]) #=> 10

json_lisp_env.evaluate_json('["+", "a", ["-", "b", 2]]') #=> 10
```

## See Also

1. [JSON Lisp for JavaScript](https://github.com/jellymann/json-lisp-js)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jellymann/json-lisp-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
