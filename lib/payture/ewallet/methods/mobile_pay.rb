# frozen_string_literal: true

module Payture::Ewallet
  module Methods
    class MobilePay < Base
      private

      def url
        "https://#{config.host}/api/MobilePay"
      end

      def params(order_id:, pay_token:, amount: nil, cheque: nil, mobile_subsystem:)
        raise(Error, "Only GPay and ApplePay systems allowed") unless mobile_subsystem.in? %w(gpay applepay)

        params = {
          PayToken: Base64.strict_encode64(pay_token),
          OrderId: order_id,
          Key: ( config.key || config.merchant_id ),
        }

        params[:Cheque] = encoded_cheque(cheque) if cheque

        if mobile_subsystem == 'gpay'
          params[:Amount] = amount.cents
        end

        params
      end

      def response_class
        Responses::MobilePay
      end
    end
  end
end
