module BrInvoicesPdf
  module Cfe
    module Renderer
      module CompanyIdentification
        extend BaseRenderer

        module_function

        def execute(pdf, data)
          attributes = data[:company_attributes]
          pdf_setup(pdf) do
            company_params(pdf, attributes)
            address_params = attributes[:address]
            pdf.text(format_address(address_params), align: :center)
          end
        end

        # :reek:FeatureEnvy
        def pdf_setup(pdf)
          pdf.bounding_box([0, pdf.cursor], width: page_content_width(pdf)) do
            pdf.pad(10) do
              pdf.indent(10, 10) do
                yield
              end
            end
            pdf.stroke_bounds
          end
        end
        private_class_method :pdf_setup

        # :reek:FeatureEnvy
        def company_params(pdf, data)
          pdf.text(data[:company_name], align: :center)
          pdf.text(data[:trading_name], align: :center)
          pdf.text('CNPJ: ' + format_cnpj(data[:cnpj]), align: :center)
          pdf.text('Inscrição Estadual: ' + data[:ie], align: :center)
        end
        private_class_method :company_params
      end
    end
  end
end
