module BraspagRest
  class RecurrentPayment < Hashie::IUTrash
    include Hashie::Extensions::Coercion

    property :request_id, from: 'RequestId'
    property :customer, from: 'Customer', with: ->(values) { BraspagRest::Customer.new(values) }
    property :recurrent_payment, from: 'RecurrentPayment', with: ->(values) { BraspagRest::RecurrentPayments::RecurrentPayment.new(values) }

    coerce_key :customer, BraspagRest::Customer
    coerce_key :recurrent_payment, BraspagRest::RecurrentPayments::RecurrentPayment

    def self.find(request_id, recurrent_payment_id)
      response = BraspagRest::Request.get_recurrent_payment(request_id, recurrent_payment_id)

      new(response.parsed_body.merge('RequestId' => request_id))
    end

    def self.deactivate(request_id, recurrent_payment_id)
      response = BraspagRest::Request.deactivate_recurrent_payment(request_id, recurrent_payment_id)
      response.success? ? true : false
    end

    def self.reactivate(request_id, recurrent_payment_id)
      response = BraspagRest::Request.reactivate_recurrent_payment(request_id, recurrent_payment_id)
      response.success? ? true : false
    end
  end
end
