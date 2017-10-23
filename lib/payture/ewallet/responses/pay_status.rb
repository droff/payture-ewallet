# frozen_string_literal: true

module Payture::Ewallet
  module Responses
    class PayStatus < Base
      def status
        body['Status']
      end

      def amount
        money(body['Amount'])
      end

      def card_id
        body['CardId']
      end

      def user_login
        body['VWUserLgn']
      end
    end
  end
end
