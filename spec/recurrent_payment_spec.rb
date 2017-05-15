require 'spec_helper'

describe BraspagRest::RecurrentPayment do
  let(:braspag_response) {
    {
      'RecurrentPaymentId' => '61e5bd30-ec11-44b3-ba0a-56fbbc8274c5',
      'ReasonCode' => 0,
      'NextRecurrency' => '2015-11-04',
      'StartDate' => '2018-11-01',
      'EndDate' => '2019-12-01',
      'Interval' => 'SemiAnnual',
      'AuthorizeNow' => true
    }
  }

  describe '.new' do
    subject(:recurrent_payment) { BraspagRest::RecurrentPayment.new(braspag_response) }

    it 'initializes a recurrent payment using braspag response format' do
      expect(recurrent_payment.id).to eq('61e5bd30-ec11-44b3-ba0a-56fbbc8274c5')
      expect(recurrent_payment.reason_code).to eq(0)
      expect(recurrent_payment.next_recurrency).to eq('2015-11-04')
      expect(recurrent_payment.start_date).to eq('2018-11-01')
      expect(recurrent_payment.end_date).to eq('2019-12-01')
      expect(recurrent_payment.interval).to eq('SemiAnnual')
      expect(recurrent_payment.authorize_now).to be_truthy
    end
  end
end
