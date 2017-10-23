# frozen_string_literal: true

module Payture::Ewallet
  module Methods
    class Charge < Base
      private

      def url
        "#{config.base_url}/Charge"
      end

      def params(order_id:, amount: nil, cheque: nil)
        {
          VWID: config.merchant_id,
          Password: config.password,
          OrderId: order_id,
          Amount: amount&.cents,
          Cheque: encoded_cheque(cheque),
        }
      end

      def response_class
        Responses::Charge
      end
    end
  end
end
