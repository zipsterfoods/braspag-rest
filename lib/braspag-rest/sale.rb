module BraspagRest
  class Sale < Hashie::IUTrash
    include Hashie::Extensions::Coercion

    attr_reader :errors

    property :request_id, from: 'RequestId'
    property :order_id, from: 'MerchantOrderId'
    property :customer, from: 'Customer', with: ->(values) { BraspagRest::Customer.new(values) }
    property :payment, from: 'Payment', with: ->(values) { BraspagRest::Payment.new(values) }

    coerce_key :customer, BraspagRest::Customer
    coerce_key :payment, BraspagRest::Payment

    def self.find(request_id, payment_id)
      response = BraspagRest::Request.get_sale(request_id, payment_id)

      new(response.parsed_body.merge('RequestId' => request_id))
    end

    def save
      response = BraspagRest::Request.authorize(request_id, inverse_attributes)

      if response.success?
        initialize_attributes(response.parsed_body)
      else
        initialize_errors(response.parsed_body) and return false
      end

      true
    end

    def cancel(amount = nil)
      response = BraspagRest::Request.void(request_id, payment.id, amount)

      if response.success?
        self.payment.initialize_attributes(response.parsed_body)
      else
        initialize_errors(response.parsed_body) and return false
      end

      payment.cancelled?
    end

    def capture(amount = nil)
      response = BraspagRest::Request.capture(request_id, payment.id, (amount || payment.amount))

      if response.success?
        self.payment.initialize_attributes(response.parsed_body)
      else
        initialize_errors(response.parsed_body) and return false
      end

      payment.captured?
    end

    def reload
      if !request_id.nil? && payment && !payment.id.nil?
        self.class.find(request_id, payment.id)
      else
        self
      end
    end

    private

    def initialize_errors(errors)
      @errors = errors.map { |error| { code: error['Code'], message: error['Message'] } }
    end
  end
end
