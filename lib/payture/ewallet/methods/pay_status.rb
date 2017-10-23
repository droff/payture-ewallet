# frozen_string_literal: true

module Payture::Ewallet
  module Methods
    class PayStatus < Base
      private

      def url
        "#{config.base_url}/PayStatus"
      end

      def params(order_id:)
        {
          VWID: config.merchant_id,
          DATA: encoded_data(
            OrderId: order_id,
          ),
        }
      end

      def response_class
        Responses::PayStatus
      end
    end
  end
end
