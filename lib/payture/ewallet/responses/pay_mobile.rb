# frozen_string_literal: true

module Payture::Ewallet
  module Responses
    class PayMobile < Base
      def charged_amount
        @charged_amount ||= money(body['Amount'])
      end
    end
  end
end
