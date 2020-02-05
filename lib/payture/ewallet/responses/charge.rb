# frozen_string_literal: true

module Payture::Ewallet
  module Responses
    class Charge < Base
      def charged_amount
        @charged_amount ||= money(body['Amount'])
      end

      def required_3ds?
        body['Success'] == '3DS'
      end

      def acs_url
        body['ACSUrl'] if required_3ds?
      end

      def md
        body['ThreeDSKey'] if required_3ds?
      end

      def pa_req
        body['PaReq'] if required_3ds?
      end
    end
  end
end
