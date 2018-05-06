# The Chartable Ruby gem

The Chartable gem is a lightweight and database-level library to transform any Active Record query into analytics hash ready for use with any chart library.

**Supported database engines:** `MySQL`, `PostgreSQL` and `SQLite`

## Installation
    gem install chartable

## Usage examples

The gem adds the `analytics` class method to all Rails models. Currently, five analytics periods are available: `yearly`, `weekly`, `monthly`, `quarterly` and `daily`. If it's not specified then it operates on the `created_at` column.

```ruby
User.analytics(:yearly) # => { 2017 => 5, 2018 => 30 }
User.analytics(:monthly) # => { "November 2018" => 1, "October 2018" => 1 }
User.analytics(:daily) # => {"October 09, 2018" => 1, "October 10, 2018" => 1}
User.analytics(:weekly) # => {"01/28/18 - 02/03/18" => 1, "02/11/18 - 02/17/18" => 1}
User.analytics(:quarterly) # => {"Q1 2018" => 1, "Q2 2018" => 1}
```

If you want to change the column used for sorting then specify the `:on` option:

```ruby
User.analytics(:yearly, on: 'updated_at')
```

If you want to narrow the results you can pass `from:` or/and `to:` options. You can pass any valid value of type `String`, `Date`, `DateTime` or `Time` - it will be transformed to the date format:

```ruby
User.analytics(:yearly, from: Date.yesterday, to: Date.today)
```

You can also call `analytics` on any query:

```ruby
User.where(first_name: 'John').where.not(last_name: 'Doe').analytics(:daily)
```

## Supported Ruby Versions

This gem was tested on the 2.5.0 version. If it's not working with older versions please add a new issue.

## Committers and Contributors

* Paweł Dąbrowski ([rubyhero](https://github.com/rubyhero))
* Tran Xuan Nam ([namtx](https://github.com/namtx))

## TODO

* Add the CHANGELOG file
* Add a separated query class for each database driver
* When a date period is restricted then return 0 for periods without the data
* Test code with the older Ruby versions

## Copyright

Copyright (c) 2018 Paweł Dąbrowski.
See [LICENSE][] for details.

[license]: LICENSE.md
