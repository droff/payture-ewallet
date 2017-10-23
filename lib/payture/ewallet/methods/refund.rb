# frozen_string_literal: true

module Payture::Ewallet
  module Methods
    class Refund < Base
      private

      def url
        "#{config.base_url}/Refund"
      end

      def params(order_id:, amount:, cheque: nil)
        {
          VWID: config.merchant_id,
          DATA: encoded_data(
            Password: config.password,
            OrderId: order_id,
            Amount: amount.cents,
            Cheque: encoded_cheque(cheque),
          ),
        }
      end

      def response_class
        Responses::Refund
      end
    end
  end
end
