# frozen_string_literal: true

module Payture::Ewallet
  module Responses
    class GetList < Base
      def active_item
        items.find { |item| item['Status'] == 'IsActive' }
      end

      def items
        item = body['Item']
        return [item] if item.is_a?(Hash)

        item || []
      end

      def status
        body['Status']
      end

      def user_login
        body['VWUserLgn']
      end
    end
  end
end
