# frozen_string_literal: true

module Payture::Ewallet
  class Config
    DEFAULT_HOST = 'sandbox.payture.com'
    DEFAULT_CURRENCY = 'RUB'

    # required with default
    attr_reader :host
    attr_reader :currency

    # required
    attr_reader :merchant_id
    attr_reader :password

    # optional
    attr_reader :logger
    attr_reader :timeout
    attr_reader :open_timeout

    def initialize(**options)
      @host = options[:host] || DEFAULT_HOST
      @currency = options[:currency] || DEFAULT_CURRENCY
      @merchant_id = options[:merchant_id]
      @password = options[:password]
      @logger = options[:logger]
      @timeout = options[:timeout]
      @open_timeout = options[:open_timeout]

      check_required_fields!
    end

    def base_url
      "https://#{host}/vwapi"
    end

    private

    def check_required_fields!
      unless merchant_id && password
        raise ArgumentError, 'Required options: merchant_id, password'
      end
    end
  end
end
