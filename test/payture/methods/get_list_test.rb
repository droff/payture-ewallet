# frozen_string_literal: true

require 'test_helper'

describe Payture::Ewallet::Methods::GetList do
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
      VCR.use_cassette('get_list_success') do
        @client.get_list(user_login: '123@ya.ru', password: '2645363')
      end

    assert response.success?
    assert_equal '123@ya.ru', response.user_login
    assert_equal 2, response.items.count
    assert_includes response.items.map { |item| item['Status'] }, "IsActive"
    assert_equal '001f2def-64e9-4cef-ae02-aa2bd9508a8b', response.active_item['CardId']

    refute response.error?
    assert_nil response.error_code
  end

  it 'returns success response with empty item' do
    response =
      VCR.use_cassette('get_list_success_with_empty_item') do
        @client.get_list(user_login: '123@ya.ru', password: '2645363')
      end

    assert response.success?
    assert_equal '123@ya.ru', response.user_login
    assert_equal 0, response.items.count
    assert_nil response.active_item

    refute response.error?
    assert_nil response.error_code
  end

  it 'returns error response' do
    response =
      VCR.use_cassette('get_list_error') do
        @client.get_list(user_login: '123@ya.ru', password: '123')
      end

    assert response.error?
    assert_equal 'WRONG_USER_PARAMS', response.error_code

    refute response.success?
  end
end
