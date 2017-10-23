# Payture::Ewallet

[![Build Status](https://travis-ci.org/busfor/payture-ewallet.svg?branch=master)](https://travis-ci.org/busfor/payture-ewallet)

Simple Ruby wrapper for [Payture eWallet API](http://payture.com/integration/api/#ewallet_).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'payture-ewallet'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install payture-ewallet

## Usage

### Create client

Required options is a `merchant_id` and `password`. You can get them from Payture tech support.

```ruby
payture = Payture::Ewallet.client(
  host: 'sandbox.payture.com',
  merchant_id: 'TestMerchant',
  password: '12345',
  currency: 'RUB',
)
```

You can also specify optional settings:

```ruby
payture = Payture::Ewallet.client(
  host: 'sandbox.payture.com',
  merchant_id: 'TestMerchant',
  password: '12345',
  currency: 'RUB',
  timeout: 10,
  open_timeout: 5,
  logger: Logger.new,
)
```

### Init payment

```ruby
response = payture.init(
  user_login: 'user@gmail.com',
  user_password: '12345',
  user_ip: '192.168.0.1',
  order_id: '123',
  amount: Money.new(100_00, 'RUB'),
)

response.success?
# => true
response.session_id
# => "36a02faf-ae1b-443b-8fcc-188614390a91"
```

If response has error:

```ruby
response.error?
# => true
response.error_code
# => "DUPLICATE_ORDER_ID"
```

### Build payment URL

`session_id` contains value from previous step.

```ruby
payture.pay_url(session_id: '36a02faf-ae1b-443b-8fcc-188614390a91')
=> "https://sandbox.payture.com/vwapi/Pay?SessionId=36a02faf-ae1b-443b-8fcc-188614390a91"
```

You need redirect user to this URL.

### Charge

After the user has paid, you can charge money from card:

```ruby
response = payture.charge(
  order_id: '123',
  amount: Money.new(100_00, 'RUB'),
)

response.success?
# => true
response.charged_amount
# => #<Money fractional:10000 currency:RUB>
```

### Unblock

You also can unblock money if you don't need charge them:

```ruby
response = payture.unblock(
  order_id: '123',
  amount: Money.new(100_00, 'RUB'),
)

response.success?
# => true
response.actual_amount
# => #<Money fractional:0 currency:RUB>
```

### Refund

If money already charged, you can refund them:

```ruby
response = payture.refund(
  order_id: '123',
  amount: Money.new(80_00, 'RUB'),
)

response.success?
# => true
response.actual_amount
# => #<Money fractional:2000 currency:RUB>
```

### Payment status

For get actual payment status you can use method `pay_status`:

```ruby
response = payture.pay_status(order_id: '123')

response.success?
# => true
response.status
# => "Authorized"
response.amount
# => #<Money fractional:10000 currency:RUB>
response.card_id
# => "..."
response.user_login
# => "user@gmail.com"
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/busfor/payture-ewallet. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

