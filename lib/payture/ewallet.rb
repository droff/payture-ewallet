# frozen_string_literal: true

require 'faraday'
require 'multi_xml'
require 'money'

require 'payture/ewallet/version'

require 'payture/ewallet/client'
require 'payture/ewallet/config'
require 'payture/ewallet/error'
require 'payture/ewallet/make_pay_url'
require 'payture/ewallet/methods/base'
require 'payture/ewallet/methods/init'
require 'payture/ewallet/methods/charge'
require 'payture/ewallet/methods/unblock'
require 'payture/ewallet/methods/refund'
require 'payture/ewallet/methods/pay_status'
require 'payture/ewallet/methods/mobile_pay'
require 'payture/ewallet/responses/base'
require 'payture/ewallet/responses/init'
require 'payture/ewallet/responses/charge'
require 'payture/ewallet/responses/refund'
require 'payture/ewallet/responses/pay_status'

module Payture
  module Ewallet
    def self.client(**args)
      Client.new(**args)
    end
  end
end
