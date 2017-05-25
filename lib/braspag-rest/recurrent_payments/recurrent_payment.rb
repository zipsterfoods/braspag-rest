module BraspagRest
  module RecurrentPayments
    class RecurrentPayment < Hashie::IUTrash
      include Hashie::Extensions::Coercion

      property :id, from: 'RecurrentPaymentId'
      property :next_recurrency, from: 'NextRecurrency'
      property :start_date, from: 'StartDate'
      property :end_date, from: 'EndDate'
      property :interval, from: 'Interval'
      property :amount, from: 'Amount'
      property :country, from: 'Country'
      property :create_at, from: 'CreateDate'
      property :currency, from: 'Currency'
      property :current_recurrency_try, from: 'CurrentRecurrencyTry'
      property :provider, from: 'Cielo'
      property :recurrency_day, from: 'RecurrencyDay'
      property :successful_recurrences, from: 'SuccessfulRecurrences'
      property :status, from: 'Status'
    end
  end
end
