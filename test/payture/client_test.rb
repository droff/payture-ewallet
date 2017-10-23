# frozen_string_literal: true

require 'test_helper'

describe Payture::Ewallet::Client do
  describe 'required settings' do
    it 'requires host' do
      error_message = 'Required options: host, merchant_id, password, currency'
      assert_raises(ArgumentError, error_message) do
        Payture::Ewallet.client(
          merchant_id: 'TestMerchant',
          password: '12345',
          currency: 'RUB',
        )
      end
    end

    it 'requires merchant_id' do
      error_message = 'Required options: host, merchant_id, password, currency'
      assert_raises(ArgumentError, error_message) do
        Payture::Ewallet.client(
          host: 'sandbox.payture.com',
          password: '12345',
          currency: 'RUB',
        )
      end
    end

    it 'requires password' do
      error_message = 'Required options: host, merchant_id, password, currency'
      assert_raises(ArgumentError, error_message) do
        Payture::Ewallet.client(
          host: 'sandbox.payture.com',
          merchant_id: 'TestMerchant',
          currency: 'RUB',
        )
      end
    end

    it 'requires currency' do
      error_message = 'Required options: host, merchant_id, password, currency'
      assert_raises(ArgumentError, error_message) do
        Payture::Ewallet.client(
          host: 'sandbox.payture.com',
          merchant_id: 'TestMerchant',
          password: '12345',
        )
      end
    end
  end

  describe '#config' do
    it 'returns config with correct params' do
      client = Payture::Ewallet.client(
        host: 'sandbox.payture.com',
        merchant_id: 'TestMerchant',
        password: '123456',
        currency: 'RUB',
      )

      assert_equal 'sandbox.payture.com', client.config.host
      assert_equal 'TestMerchant', client.config.merchant_id
      assert_equal '123456', client.config.password
      assert_equal 'RUB', client.config.currency
    end

    it 'has optional params' do
      client = Payture::Ewallet.client(
        host: 'sandbox.payture.com',
        merchant_id: 'TestMerchant',
        password: '123456',
        currency: 'RUB',
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
