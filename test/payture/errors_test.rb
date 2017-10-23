# frozen_string_literal: true

require 'test_helper'

describe Payture::Ewallet::Error do
  before do
    @client = Payture::Ewallet.client(
      merchant_id: 'TestMerchant',
      password: 'merchant12345',
    )
  end

  it 'raises error when request timeouted' do
    VCR.turn_off!
    stub_request(:get, /sandbox.payture.com/).to_timeout

    expected_message = 'Faraday::ConnectionFailed: execution expired'
    assert_raises(Payture::Ewallet::Error, expected_message) do
      @client.charge(
        order_id: 'order123',
        amount: Money.new(100_00, 'RUB'),
      )
    end

    VCR.turn_on!
  end

  it 'raises error when payture returns invalid http status' do
    VCR.use_cassette('error_http_status') do
      assert_raises(Payture::Ewallet::Error, 'Invalid http status: 500') do
        @client.charge(
          order_id: 'order123',
          amount: Money.new(100_00, 'RUB'),
        )
      end
    end
  end

  it 'raises error when payture returns invalid body' do
    VCR.use_cassette('error_invalid_body') do
      expected_message = 'MultiXml::ParseError: The document "This is not XML" does not have a valid root'
      assert_raises(Payture::Ewallet::Error, expected_message) do
        @client.charge(
          order_id: 'order123',
          amount: Money.new(100_00, 'RUB'),
        )
      end
    end
  end
end
