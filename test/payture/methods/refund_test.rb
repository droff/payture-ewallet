# frozen_string_literal: true

require 'test_helper'

describe Payture::Ewallet::Methods::Refund do
  before do
    @client = Payture::Ewallet.client(
      merchant_id: 'TestMerchant',
      password: 'merchant12345',
    )
  end

  it 'returns success response' do
    response =
      VCR.use_cassette('refund_success') do
        @client.refund(
          order_id: 'order123',
          amount: Money.new(100_00, 'RUB'),
        )
      end

    assert response.success?
    assert_equal Money.new(0, 'RUB'), response.actual_amount

    refute response.error?
    assert_nil response.error_code
  end

  it 'returns success response with partial refund' do
    response =
      VCR.use_cassette('refund_partial_success') do
        @client.refund(
          order_id: 'order123',
          amount: Money.new(80_00, 'RUB'),
        )
      end

    assert response.success?
    assert_equal Money.new(20_00, 'RUB'), response.actual_amount

    refute response.error?
    assert_nil response.error_code
  end

  it 'returns error response' do
    response =
      VCR.use_cassette('refund_error') do
        @client.refund(
          order_id: 'order123',
          amount: Money.new(200_00, 'RUB'),
        )
      end

    assert response.error?
    assert_equal 'AMOUNT_ERROR', response.error_code

    refute response.success?
    assert_nil response.actual_amount
  end
end
