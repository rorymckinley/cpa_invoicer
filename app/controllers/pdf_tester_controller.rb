require 'prawn'

class PdfTester < ApplicationController
  def show
    send_data build_pdf, filename: "stuff.pdf", type: "application/pdf"
  end

  def build_pdf
    pdf = Prawn::Document.new
    pdf.text "YukYukYuk"
    pdf.render
  end
end
