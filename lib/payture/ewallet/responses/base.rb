# frozen_string_literal: true

module Payture::Ewallet
  module Responses
    class Base
      attr_reader :body

      def initialize(body, currency:)
        @body = body
        @currency = currency
      end

      def success?
        body['Success'] == 'True'
      end

      def error?
        !success?
      end

      def error_code
        body['ErrCode']
      end

      private

      def money(value)
        return value unless value && @currency

        Money.new(value.to_i, @currency)
      end
    end
  end
end
