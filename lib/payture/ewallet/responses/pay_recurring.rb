# frozen_string_literal: true

module Payture::Ewallet
  module Responses
    class PayRecurring < Base
      def amount
        money(body['Amount'])
      end

      def order_id
        body['OrderId']
      end

      def merchant_order_id
        body['MerchantOrderId']
      end

      def user_login
        body['VWUserLgn']
      end
    end
  end
end
