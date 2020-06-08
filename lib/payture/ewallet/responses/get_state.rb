# frozen_string_literal: true

module Payture::Ewallet
  module Responses
    class GetState < Base
      def status
        body['Status']
      end

      def card_id
        body['CardId']
      end

      def pan_mask
        body['PANMask']
      end

      def user_login
        body['VWUserLgn']
      end
    end
  end
end
