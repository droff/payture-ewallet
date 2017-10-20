# frozen_string_literal: true

require 'test_helper'

describe Payture::Ewallet::Methods::Init do
  before do
    @client = Payture::Ewallet.client(
      merchant_id: 'TestMerchant',
      password: 'merchant12345',
    )
  end

  it 'returns success response' do
    response =
      VCR.use_cassette('init_success') do
        @client.init(
          user_login: 'user@gmail.com',
          user_password: 'user12345',
          user_ip: '192.168.0.1',
          order_id: 'order123',
          amount: Money.new(100_00, 'RUB'),
        )
      end

    assert response.success?
    assert_equal '36a02faf-ae1b-443b-8fcc-188614390a91', response.session_id

    refute response.error?
    assert_nil response.error_code
  end

  it 'returns error response' do
    response =
      VCR.use_cassette('init_error') do
        @client.init(
          user_login: 'user@gmail.com',
          user_password: 'user12345',
          user_ip: '192.168.0.1',
          order_id: 'order123',
          amount: Money.new(100_00, 'RUB'),
        )
      end

    assert response.error?
    assert_equal 'DUPLICATE_ORDER_ID', response.error_code

    refute response.success?
    assert_nil response.session_id
  end
end
