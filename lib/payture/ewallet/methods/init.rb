# frozen_string_literal: true

module Payture::Ewallet
  module Methods
    class Init < Base
      private

      def url
        "#{config.base_url}/Init"
      end

      # rubocop:disable Metrics/ParameterLists, Metrics/LineLength
      def params(user_login:, user_password:, user_ip:, order_id:, amount:, **optional)
        {
          VWID: config.merchant_id,
          DATA: encoded_data(
            SessionType: 'Block',
            VWUserLgn: user_login,
            VWUserPsw: user_password,
            IP: user_ip,
            PhoneNumber: optional[:user_phone],
            OrderId: order_id,
            Amount: amount.cents,
            TemplateTag: optional[:template],
            Language: optional[:language],
          ),
        }
      end

      def response_class
        Responses::Init
      end
    end
  end
end
