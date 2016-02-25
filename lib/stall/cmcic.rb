require 'cic_payment'

module Stall
  module Cmcic
    extend ActiveSupport::Autoload

    autoload :CicPayment
    autoload :Version
    autoload :Utils
    autoload :FakeGatewayPaymentNotification
  end
end

require 'stall/cmcic/gateway'
require 'stall/cmcic/engine'
