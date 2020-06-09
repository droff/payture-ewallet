# frozen_string_literal: true

module Payture::Ewallet
  module Methods
    class GetList < Base
      private

      def url
        "#{config.base_url}/GetList"
      end

      def params(user_login:, password:)
        {
          VWID: config.merchant_id,
          DATA: encoded_data(
            VWUserLgn: user_login,
            VWUserPsw: password
          )
        }
      end

      def response_class
        Responses::GetList
      end
    end
  end
end
