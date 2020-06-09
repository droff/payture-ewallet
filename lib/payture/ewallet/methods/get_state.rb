# frozen_string_literal: true

module Payture::Ewallet
  module Methods
    class GetState < Base
      private

      def url
        "#{config.base_url}/GetState"
      end

      def params(order_id:)
        {
          Key: config.merchant_id,
          OrderId: order_id
        }
      end

      def response_class
        Responses::GetState
      end
    end
  end
end
