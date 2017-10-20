# frozen_string_literal: true

require 'faraday'
require 'multi_xml'
require 'money'

require 'payture/ewallet/version'

require 'payture/ewallet/client'
require 'payture/ewallet/config'

module Payture
  module Ewallet
    def self.client(**args)
      Client.new(**args)
    end
  end
end
