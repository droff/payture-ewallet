# frozen_string_literal: true

module Payture::Ewallet
  module Responses
    class Refund < Base
      def actual_amount
        @actual_amount ||= money(body['NewAmount'])
      end
    end
  end
end
