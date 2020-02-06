# frozen_string_literal: true

require 'test_helper'

describe Payture::Ewallet::Methods::Charge do
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
      VCR.use_cassette('charge_success') do
        @client.charge(
          order_id: 'order123',
          amount: Money.new(100_00, 'RUB'),
        )
      end

    assert response.success?
    assert_equal Money.new(100_00, 'RUB'), response.charged_amount

    refute response.error?
    assert_nil response.error_code
  end

  it 'returns error response' do
    response =
      VCR.use_cassette('charge_error') do
        @client.charge(
          order_id: 'order123',
          amount: Money.new(200_00, 'RUB'),
        )
      end

    assert response.error?
    assert_equal 'AMOUNT_ERROR', response.error_code

    refute response.success?
    assert_nil response.charged_amount
  end

  it 'returns 3ds params if 3ds needed' do
    response =
      VCR.use_cassette('charge_success_3ds') do
        @client.charge(
          order_id: 'order123',
          amount: Money.new(100_00, 'RUB'),
        )
      end

    refute response.success?
    assert response.required_3ds?

    assert_equal 'MD', response.md
    assert_equal 'PaReq', response.pa_req
    assert_equal 'AcsUrl', response.acs_url
  end
end
