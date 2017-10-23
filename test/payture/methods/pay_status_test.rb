# frozen_string_literal: true

require 'test_helper'

describe Payture::Ewallet::Methods::PayStatus do
  before do
    @client = Payture::Ewallet.client(
      host: 'sandbox.payture.com',
      merchant_id: 'TestMerchant',
      password: 'merchant12345',
      currency: 'RUB',
    )
  end

  it 'returns success response' do
    response =
      VCR.use_cassette('pay_status_success') do
        @client.pay_status(order_id: 'order123')
      end

    assert response.success?
    assert_equal 'Authorized', response.status
    assert_equal Money.new(100_00, 'RUB'), response.amount
    assert_equal '', response.card_id
    assert_equal 'user@gmail.com', response.user_login

    refute response.error?
    assert_nil response.error_code
  end

  it 'returns error response' do
    response =
      VCR.use_cassette('pay_status_error') do
        @client.pay_status(order_id: 'order123')
      end

    assert response.error?
    assert_equal 'ORDER_TIME_OUT', response.error_code

    refute response.success?
    assert_nil response.status
    assert_nil response.amount
    assert_nil response.card_id
    assert_equal '', response.user_login
  end
end
