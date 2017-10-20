# frozen_string_literal: true

require 'test_helper'

describe Payture::Ewallet::Client do
  it 'requires merchant_id' do
    assert_raises(ArgumentError, 'Required options: merchant_id, password') do
      Payture::Ewallet.client(password: '123456')
    end
  end

  it 'requires password' do
    assert_raises(ArgumentError, 'Required options: merchant_id, password') do
      Payture::Ewallet.client(merchant_id: 'TestMerchant')
    end
  end

  describe '#config' do
    it 'returns config with correct params' do
      client = Payture::Ewallet.client(
        merchant_id: 'TestMerchant',
        password: '123456',
      )

      assert_equal 'TestMerchant', client.config.merchant_id
      assert_equal '123456', client.config.password
    end

    it 'has default values for host and currency' do
      client = Payture::Ewallet.client(
        merchant_id: 'TestMerchant',
        password: '123456',
      )

      assert_equal 'sandbox.payture.com', client.config.host
      assert_equal 'RUB', client.config.currency
    end

    it 'overrides default params' do
      client = Payture::Ewallet.client(
        merchant_id: 'TestMerchant',
        password: '123456',
        host: 'payture.com',
        currency: 'EUR',
      )

      assert_equal 'payture.com', client.config.host
      assert_equal 'EUR', client.config.currency
    end

    it 'has optional params' do
      client = Payture::Ewallet.client(
        merchant_id: 'TestMerchant',
        password: '123456',
        timeout: 10,
        open_timeout: 5,
        logger: 'logger',
      )

      assert_equal 10, client.config.timeout
      assert_equal 5, client.config.open_timeout
      assert_equal 'logger', client.config.logger
    end
  end
end
