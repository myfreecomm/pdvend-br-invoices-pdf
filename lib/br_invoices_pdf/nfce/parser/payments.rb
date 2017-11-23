# frozen_string_literal: true

module BrInvoicesPdf
  module Nfce
    module Parser
      module Payments
        extend Util::XmlLocate

        module_function

        def execute(xml)
          node_payments = xml.locate("#{root_path(xml)}/pag")

          node_payments.map(&method(:payment_by))
        end

        def payment_by(element)
          {
            type: Util::Enum::PAYMENT_TYPES[locate_element(element, 'tPag')],
            amount: locate_element(element, 'vPag'),
            cashback: locate_element(element, 'vTroco')
          }
        end
        private_class_method :payment_by
      end
    end
  end
end
