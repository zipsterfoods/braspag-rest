require 'spec_helper'

describe BraspagRest::RecurrentPayment do
  let(:braspag_response) {
    {
        "Customer" => {
            "Name": "Comprador accept"
        },
        "RecurrentPayment" => {
            "RecurrentPaymentId" => "6716406f-1cba-4c7a-8054-7e8988032b17",
            "NextRecurrency" => "2015-11-05",
            "StartDate" => "2015-05-05",
            "EndDate" => "2019-12-01",
            "Interval" => "SemiAnnual",
            "Amount" => 1500,
            "Country" => "BRA",
            "CreateDate" => "2015-06-25T00:00:00",
            "Currency" => "BRL",
            "CurrentRecurrencyTry" => 0,
            "Provider" => "Cielo",
            "RecurrencyDay" => 21,
            "SuccessfulRecurrences" => 0,
            "Links" =>  [
                {
                    "Method" => "GET",
                    "Rel" => "self",
                    "Href" => "https://apihomolog.braspag.com.br/v2/RecurrentPayment/6716406f-1cba-4c7a-8054-7e8988032b17"
                }
            ],
            "RecurrentTransactions" => [],
            "Status" => 1
        }
    }
  }

  subject(:recurrent_payment) { BraspagRest::RecurrentPayment.new(braspag_response) }

  describe '.new' do
    it 'initializes a recurrent_payment using braspag response format' do
      expect(recurrent_payment.customer).to be_an_instance_of(BraspagRest::Customer)
      expect(recurrent_payment.recurrent_payment).to be_an_instance_of(BraspagRest::RecurrentPayments::RecurrentPayment)
    end
  end

  describe '.find' do
    before { allow(BraspagRest::Request).to receive(:get_recurrent_payment).and_return(double(parsed_body: braspag_response)) }

    it 'calls braspag gateway with request_id and recurrent_payment_id' do
      expect(BraspagRest::Request).to receive(:get_recurrent_payment).with('xxx-xxx-xxx', '1234-xpto').and_return(double(parsed_body: braspag_response))

      BraspagRest::RecurrentPayment.find('xxx-xxx-xxx', '1234-xpto')
    end

    it 'returns a populated recurrent_payment object' do
      recurrent_payment = BraspagRest::RecurrentPayment.find('xxx-xxx-xxx', '1234-xpto')
      expect(recurrent_payment.customer).to be_an_instance_of(BraspagRest::Customer)
      expect(recurrent_payment.recurrent_payment).to be_an_instance_of(BraspagRest::RecurrentPayments::RecurrentPayment)
      expect(recurrent_payment.recurrent_payment.id).to eq('6716406f-1cba-4c7a-8054-7e8988032b17')
    end
  end

  describe '.deactivate' do
    context 'when the gateway returns a successful response' do
      let(:response) { double(success?: true, parsed_body: "") }
  
      before { allow(BraspagRest::Request).to receive(:deactivate_recurrent_payment).and_return(response) }

      it 'calls braspag gateway with request_id and recurrent_payment_id' do
        expect(BraspagRest::Request).to receive(:deactivate_recurrent_payment).with('xxx-xxx-xxx', '1234-xpto').and_return(response)

        BraspagRest::RecurrentPayment.deactivate('xxx-xxx-xxx', '1234-xpto')
      end

      it 'returns true' do
        success = BraspagRest::RecurrentPayment.deactivate('xxx-xxx-xxx', '1234-xpto')

        expect(success).to be_truthy
      end
    end

    context 'when is a failure by not found exception' do
      let(:response) { double(success?: false, parsed_body: "") }

      it 'returns false' do
        allow(BraspagRest::Request).to receive(:deactivate_recurrent_payment).and_return(response)

        success = BraspagRest::RecurrentPayment.deactivate('xxx-xxx-xxx', '1234-xpto-not-found')

        expect(success).to be_falsy
      end
    end
  end
end
