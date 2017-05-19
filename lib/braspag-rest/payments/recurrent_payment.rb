module BraspagRest
  module Payments
    class RecurrentPayment < Hashie::IUTrash
      include Hashie::Extensions::Coercion

      property :authorize_now, from: 'AuthorizeNow'
      property :end_date, from: 'EndDate'
      property :start_date, from: 'StartDate'
      property :interval, from: 'Interval'

      # Response
      property :reason_code, from: 'FraudAnalysisReasonCode'
      property :id, from: 'RecurrentPaymentId'
      property :reason_code, from: 'ReasonCode'
      property :reason_message, from: 'ReasonMessage'
      property :next_recurrency, from: 'NextRecurrency'


      def self.find(request_id, recurrent_payment_id)
        response = BraspagRest::Request.get_recurrent_payment(request_id, recurrent_payment_id)

        new(response.parsed_body.merge('RequestId' => request_id))
      end
    end
  end
end



# {
#     "Customer": 
#     {
#         "Name": "Comprador accept"
#     },
#     "RecurrentPayment": {
#         "RecurrentPaymentId": "6716406f-1cba-4c7a-8054-7e8988032b17",
#         "NextRecurrency": "2015-11-05",
#         "StartDate": "2015-05-05",
#         "EndDate": "2019-12-01",
#         "Interval": "SemiAnnual",
#         "Amount": 1500,
#         "Country": "BRA",
#         "CreateDate": "2015-06-25T00:00:00",
#         "Currency": "BRL",
#         "CurrentRecurrencyTry": 0,
#         "Provider": "Cielo",
#         "RecurrencyDay": 21,
#         "SuccessfulRecurrences": 0,
#         "Links": [
#             {
#                 "Method": "GET",
#                 "Rel": "self",
#                 "Href": "https://apiquerysandbox.braspag.com.br/v2/RecurrentPayment/{RecurrentPaymentId}"
#             }
#         ],
#         "RecurrentTransactions": [],
#         "Status": 1
#     }
# }