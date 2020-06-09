# frozen_string_literal: true

require 'test_helper'

describe Payture::Ewallet::Methods::GetState do
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
      VCR.use_cassette('get_state_success') do
        @client.get_state(order_id: 'order123')
      end

    assert response.success?
    assert_equal 'f224dd93-ac8c-3025-65dd-963c5b3fc0cc', response.card_id
    assert_equal '123@ya.ru', response.user_login

    refute response.error?
    assert_nil response.error_code
  end

  it 'returns error response' do
    response =
      VCR.use_cassette('get_state_error') do
        @client.get_state(order_id: 'order123')
      end

    assert response.error?
    assert_equal 'ORDER_TIME_OUT', response.error_code

    refute response.success?
    assert_nil response.status
    assert_nil response.card_id
    assert_equal nil, response.user_login
  end
end
