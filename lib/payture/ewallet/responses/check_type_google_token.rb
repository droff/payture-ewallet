# frozen_string_literal: true

module Payture::Ewallet
  module Responses
    class CheckTypeGoogleToken < Base
      TOKEN_TYPES = {
        '0' => :unknown,
        '1' => :untokenized,
        '2' => :tokenized,
      }.freeze

      def type
        TOKEN_TYPES(body['Type'])
      end
    end
  end
end
