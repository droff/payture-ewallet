# frozen_string_literal: true

module Payture::Ewallet
  module Methods
    class PayRecurring < Base
      private

      def url
        "#{config.base_url}/Pay"
      end

      def params(user_login:, user_password:, card_id:, order_id:, amount:, **optional)
        {
          VWID: config.merchant_id,
          DATA: encoded_data(
            VWUserLgn: user_login,
            VWUserPsw: user_password,
            CardId: card_id,
            OrderId: order_id,
            Amount: amount&.cents,
            SessionType: optional[:session_type] || 'Pay',
            Cheque: encoded_cheque(optional[:cheque])
          )
        }
      end

      def response_class
        Responses::PayRecurring
      end
    end
  end
end
