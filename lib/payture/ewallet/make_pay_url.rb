# frozen_string_literal: true

module Payture::Ewallet
  class MakePayUrl
    attr_reader :config

    def initialize(config)
      @config = config
    end

    def call(session_id)
      "#{config.base_url}/Pay?SessionId=#{session_id}"
    end
  end
end
