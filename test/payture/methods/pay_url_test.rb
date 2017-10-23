# frozen_string_literal: true

require 'test_helper'

describe Payture::Ewallet::MakePayUrl do
  before do
    @client = Payture::Ewallet.client(
      host: 'sandbox.payture.com',
      merchant_id: 'TestMerchant',
      password: 'merchant12345',
      currency: 'RUB',
    )
  end

  it 'returns payment url' do
    url = @client.pay_url(session_id: '12345')
    expected_url = 'https://sandbox.payture.com/vwapi/Pay?SessionId=12345'

    assert_equal expected_url, url
  end
end
