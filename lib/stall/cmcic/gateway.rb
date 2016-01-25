module Stall
  module CMCIC
    class Gateway < Stall::Payments::Gateway
      register 'cmcic'

      def self.cart_id_from(request)
        if (response = response_from(request))
          cart_id_from_transaction_id(response['reference'])
        end
      end

      def self.response_from(request)
        CicPayment.new.response(
          Rack::Utils.parse_nested_query(
            request.raw_post
          )
        )
      end

      def process_payment_for(request)
        @request = request
        cart.payment.pay! if succcess?
      end

      def request
        @request ||= CicPayment.new.request(
          montant: cart.total_price,
          reference: transaction_id,
          texte_libre: I18n.t('stall.carts.formats.name', ref: cart.reference)
        )
      end

      def response
        @response ||= self.class.response_from(request)
      end

      def rendering_options
        return_code = valid_response? ? '0' : '1'
        { text: "version=2\ncdr=#{ return_code }\n" }
      end

      def success?
        response[:success]
      end

      def valid_response?
        response[:success] || (response["code-retour"].downcase == "annulation")
      end
    end
  end
end
