# frozen_string_literal: true

module Payture::Ewallet
  class Config
    # required
    attr_reader :host
    attr_reader :merchant_id
    attr_reader :password
    attr_reader :currency

    # optional
    attr_reader :logger
    attr_reader :timeout
    attr_reader :open_timeout

    def initialize(**options)
      @host = options[:host]
      @merchant_id = options[:merchant_id]
      @password = options[:password]
      @currency = options[:currency]
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
      unless host && merchant_id && password && currency
        raise ArgumentError,
          'Required options: host, merchant_id, password, currency'
      end
    end
  end
end
