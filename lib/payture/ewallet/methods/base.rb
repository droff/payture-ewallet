# frozen_string_literal: true

module Payture::Ewallet
  module Methods
    class Base
      attr_reader :config

      def initialize(config)
        @config = config
      end

      def call(**args)
        http_response = make_request(url, params(**args))
        build_response(http_response)
      end

      private

      def url
        raise NotImplementedError
      end

      def params
        raise NotImplementedError
      end

      def response_class
        raise NotImplementedError
      end

      def make_request(url, params)
        conn = Faraday.new do |builder|
          builder.adapter Faraday.default_adapter
          builder.request :url_encoded
          builder.response(:logger, config.logger) if config.logger
        end
        conn.get(url, compact_hash(params)) do |req|
          req.options.timeout = config.timeout if config.timeout
          req.options.open_timeout = config.open_timeout if config.open_timeout
        end
      rescue Faraday::Error => e
        raise Error, "#{e.class}: #{e.message}"
      end

      def build_response(http_response)
        unless http_response.success?
          raise Error, "Invalid http status: #{http_response.status}"
        end

        body =
          begin
            MultiXml.parse(http_response.body).values.first
          rescue MultiXml::ParseError => e
            raise Error, "#{e.class}: #{e.message}"
          end

        response_class.new(body, currency: config.currency)
      end

      def encoded_data(**params)
        params_str = compact_hash(params).map { |k, v| "#{k}=#{v}" }.join(';')
        CGI.escape(params_str)
      end

      def compact_hash(hash)
        hash.select { |k, v| k && v }
      end
    end
  end
end
