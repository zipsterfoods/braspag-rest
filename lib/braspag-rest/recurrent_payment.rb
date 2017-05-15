module BraspagRest
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
  end
end

# request_id = "d702782133fe33f4b5b1d4756015b22ecbb6580ad2dedf908611b4b74cc0695ed85e1234"
# recurrent_payment_id = "4e9a503a-bad5-425a-839f-d57b105dfad6"
# BraspagRest::RecurrentPayment.deactivate(request_id, recurrent_payment_id)

# curl \
# --request PUT "https://apihomolog.braspag.com.br/v2/RecurrentPayment/4e9a503a-bad5-425a-839f-d57b105dfad6/Deactivate" \
# --header "Content-Type: application/json" \
# --header "MerchantId: 083F8ED9-BE5D-46E1-8F24-303FF26BF0A8" \
# --header "MerchantKey: XxSjZUHeCORgQtTE6edkeIRFUaNEtAHS1oSbHZ5m" \
# --header "RequestId: d702782133fe33f4b5b1d4756015b22ecbb6580ad2dedf908611b4b74cc0695ed85e1234"

  # url: 'https://apihomolog.braspag.com.br'
  # query_url: 'https://apiqueryhomolog.braspag.com.br'
  # merchant_id: '083F8ED9-BE5D-46E1-8F24-303FF26BF0A8'
  # merchant_key: 'XxSjZUHeCORgQtTE6edkeIRFUaNEtAHS1oSbHZ5m'