# frozen_string_literal: true

require 'test_helper'

describe Payture::Ewallet::Methods::PayRecurring do
  before do
    @client = Payture::Ewallet.client(
      host: 'sandbox.payture.com',
      merchant_id: 'TestMerchant',
      password: 'merchant12345',
      currency: 'RUB',
    )

    @pay_params = {
      user_login: '123@ya.ru',
      user_password: '2645363',
      card_id: '8f8939c6-4414-464f-c451-6e9317244b22',
      order_id: 'a24573b7-a1c8-9725-6092-053c2d7d4d70',
      amount: Money.new(12611, 'RUB')
    }
  end

  it 'returns success response' do
    response =
      VCR.use_cassette('pay_recurring_success') do
        @client.pay_recurring(**@pay_params)
      end

    assert response.success?
    assert_equal @pay_params[:amount], response.amount
    assert_equal @pay_params[:order_id], response.order_id
    assert_equal @pay_params[:user_login], response.user_login

    refute response.error?
    assert_nil response.error_code
  end

  it 'returns error response' do
    response =
      VCR.use_cassette('pay_recurring_error') do
        @client.pay_recurring(**@pay_params)
      end

    assert response.error?
    assert_equal 'CARD_NOT_FOUND', response.error_code
  end
end
