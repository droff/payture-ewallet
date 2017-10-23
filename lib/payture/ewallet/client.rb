# frozen_string_literal: true

module Payture::Ewallet
  class Client
    attr_reader :config

    def initialize(**options)
      @config = Config.new(**options)
    end

    def init(**args)
      Methods::Init.new(config).call(**args)
    end

    def pay_url(session_id:)
      MakePayUrl.new(config).call(session_id)
    end

    def charge(**args)
      Methods::Charge.new(config).call(**args)
    end

    def unblock(**args)
      Methods::Unblock.new(config).call(**args)
    end

    def refund(**args)
      Methods::Refund.new(config).call(**args)
    end

    def pay_status(**args)
      Methods::PayStatus.new(config).call(**args)
    end
  end
end
