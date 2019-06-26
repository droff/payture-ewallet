# frozen_string_literal: true

module Payture::Ewallet
  module Methods
    class Charge < Base
      private

      def url
        "#{config.base_url}/MobilePay"
      end

      def params(order_id:, pay_token:, amount: nil, cheque: nil, mobile_subsystem:)
        raise unless mobile_subsystem.in? %i(gpay applepay)

        params = {
          PayToken: Base64.strict_encode64(pay_token),
          OrderId: order_id,
          Key: config.key,
          Cheque: encoded_cheque(cheque),
        }

        if mobile_subsystem == :gpay
          params[:Amount] = amount&.cents
        end

        if mobile_subsystem == :applepay
          params[:Checksum] = true
        end

        params
      end

      def response_class
        Responses::Charge
      end
    end
  end
end
