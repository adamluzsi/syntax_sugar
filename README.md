# SyntaxSugar

This lib target to help you create some dynamic syntax 
where you could create method name based logic for factory like use cases.

## Installation

Add this line to your application's Gemfile:

    gem 'syntax_sugar'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install syntax_sugar

## Usage

```ruby

    require 'syntax_sugar'
    
    hash = Hash.new
    sugar = SyntaxSugar::NullObject.new(hash, /^(.*)=$/ => :[]=, /^get_(.*)$/ => :[], /^fetch$/ => :[])
    
    sugar.asd = 'cat'
    p sugar.get_asd #> "cat"
    p hash #> {"asd"=>"cat"}
    p sugar.fetch 'asd' #> "cat"

```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/syntax_sugar/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
