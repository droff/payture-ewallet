# frozen_string_literal: true

module Payture::Ewallet
  module Methods
    class Unblock < Base
      private

      def url
        "#{config.base_url}/Unblock"
      end

      def params(order_id:, amount:)
        {
          VWID: config.merchant_id,
          Password: config.password,
          OrderId: order_id,
          Amount: amount.cents,
        }
      end

      def response_class
        Responses::Refund
      end
    end
  end
end
