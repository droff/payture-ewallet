# frozen_string_literal: true

module Payture::Ewallet
  module Responses
    class Init < Base
      def session_id
        body['SessionId']
      end
    end
  end
end
