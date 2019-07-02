# frozen_string_literal: true

module Payture::Ewallet
  module Responses
    class MobilePay < Base
      def state
        success? ? 'charged' : 'charging_error'
      end
    end
  end
end
