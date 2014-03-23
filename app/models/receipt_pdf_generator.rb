class ReceiptPdfGenerator
  def generate(receipt)
    config = ReceiptPdf::Configuration.new.build_config(receipt)
    pdf = Prawn::Document.new(page_size:  "A4", page_layout: :portrait)
    ReceiptPdf::Builder.new.build(pdf, config)
  end
  def build(pdf,config)
  end
end
