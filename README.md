![Datte](https://raw.githubusercontent.com/hyde2able/datte/master/datte.png)

A Fast and Easy DateTime Extractor in Japanese build with love by pokohide & sasaken.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'datte'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

    $ gem install datte

## Usage

```
datte = Datte::Parser.new
body = '明日の10時にxxに集合でよろしくー!'
datte.parse_date(body) do |datetime|
  # if body contains datetime, this block is excuted.
  p datetime
  # <DateTime: 2017-01-22T10:00:00+00:00 ((2457776j,36000s,0n),+0s,2299161j)>
end
```

```
datte = Datte::Parser.new
body = '3/2まで回答お願いしますー！'
datetime = datte.parse_date(body)
if datte.nil?
  puts "body doesn't contain datetime"
else
  p datetime
  # <DateTime: 2017-03-02T18:00:00+00:00 ((2457815j,64800s,0n),+0s,2299161j)>
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/datte. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
