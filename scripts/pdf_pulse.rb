require 'rubygems'
require 'bundler'

Bundler.setup

require 'prawn'
require 'prawn/measurement_extensions'

pdf = Prawn::Document.new(page_size:  "A4", page_layout: :portrait)
pdf.stroke_bounds
top_edge = pdf.bounds.height
pdf.bounding_box([0,top_edge], width: pdf.bounds.width, height:160) do
  pdf.font "Helvetica", size: 8
  pdf.text "placeholder for letterhead image"
  pdf.stroke_bounds
end
top_edge -= 160
pdf.bounding_box([0,top_edge], width: pdf.bounds.width, height:50) do
  pdf.font "Helvetica", size: 10
  pdf.pad(5) { pdf.text "DONATION RECEIPT:" }
  pdf.text "Issued in terms of Section 18A of the Income Tax Act of 1962. The donation received below will be used exclusively for the objects of the Cart Horse Protection Association in carrying out PBAs approved in terms of section 18A."
  pdf.stroke_bounds
end
top_edge -= 50
pdf.bounding_box([0,top_edge], width: pdf.bounds.width, height:18) do
  pdf.font "Helvetica", size: 10
  pdf.bounding_box([0,18], width: 120, height: 18) do
    pdf.table([["RECEIPT NO"]]) do |table|
      table.cells.borders = []
      table.cells.padding = 2
    end
  end
  pdf.bounding_box([120,18], width: 403.28, height: 18) do
    pdf.table([["10230-20140103"]], width:403.28) do |table|
      table.cells.borders = []
      table.cells.padding = 2
    end
    pdf.stroke_bounds
  end
  pdf.stroke_bounds
end
top_edge -= 18
pdf.bounding_box([0,top_edge], width: pdf.bounds.width, height:18) do
  pdf.font "Helvetica", size: 10
  pdf.bounding_box([0,18], width: 120, height: 18) do
    pdf.table([["DONOR NAME"]]) do |table|
      table.cells.borders = []
      table.cells.padding = 2
    end
    pdf.stroke_bounds
  end
  pdf.bounding_box([120,18], width: 403.28, height: 18) do
    pdf.table([["Mr Fred Flintstone"]], width:403.28) do |table|
      table.cells.borders = []
      table.cells.padding = 2
    end
    pdf.stroke_bounds
  end
  pdf.stroke_bounds
end
top_edge -= 18
pdf.bounding_box([0,top_edge], width: pdf.bounds.width, height:100) do
  pdf.font "Helvetica", size: 10
  pdf.bounding_box([0,100], width: 120, height: 100) do
    pdf.table([["ADDRESS OF DONOR"]]) do |table|
      table.cells.borders = []
      table.cells.padding = 2
    end
    pdf.stroke_bounds
  end
  pdf.bounding_box([120,100], width: 403.28, height: 100) do
    pdf.table([["345 Cave Stone Road"], ["Sonstraal Heights"], ["Durbanville"], ["7550"], ["thecave@flintstone.co.za"]]) do |table|
      table.cells.padding = 2
      table.cells.borders = []
    end
    pdf.stroke_bounds
  end
  pdf.stroke_bounds
end
top_edge -= 100
pdf.bounding_box([0,top_edge], width: pdf.bounds.width, height:18) do
  pdf.font "Helvetica", size: 10
  pdf.bounding_box([0,18], width: 120, height: 18) do
    pdf.table([["AMOUNT OF DONATION"]]) do |table|
      table.cells.borders = []
      table.cells.padding = 2
    end
  end
  pdf.bounding_box([120,18], width: 403.28, height: 18) do
    pdf.table([["R    1200.00"]], width:403.28) do |table|
      table.cells.borders = []
      table.cells.padding = 2
      table.cells.align = :right
    end
    pdf.stroke_bounds
  end
  pdf.stroke_bounds
end
top_edge -= 18
pdf.bounding_box([0,top_edge], width: pdf.bounds.width, height:160) do
  pdf.font "Helvetica", size: 10
  pdf.bounding_box([0,160], width: 120, height: 160) do
    pdf.table([["NATURE OF DONATION"]]) do |table|
      table.cells.borders = []
      table.cells.padding = 2
    end
    pdf.stroke_bounds
  end
  pdf.bounding_box([120,160], width: 403.28, height: 160) do
    pdf.table([["100016", "ZERO TOLERANCE", "R      300.00"], ["100017", "ART AUCTION", "R      500.00"], ["100018", "SHOES", "R      400.00"]], width:403.28) do |table|
      table.cells.borders = []
      table.cells.padding = 2
      table.before_rendering_page do |page|
        page.column(-1).align =  :right
      end
    end
    pdf.stroke_bounds
  end
  pdf.stroke_bounds
end
top_edge -= 100
pdf.stroke_axis
pdf.font "Helvetica", style: :bold
puts pdf.bounds.width
puts pdf.bounds.height
# pdf.text "CART HORSE PROTECTION ASSOCIATION", align: :center
# pdf.move_down 10
# pdf.text "DONATION RECEIPT", align: :center
# pdf.bounding_box([0,725], width: 260) do
#   pdf.font "Helvetica", size: 8
#   pdf.text "PO BOX 846, EPPINDUST, 7475", align: :left
#   pdf.text "info@carthorse.org.za", align: :left
#   pdf.text "http://carthorse.org.za", align: :left
# end
# pdf.bounding_box([261,725], width: 260) do
#   pdf.font "Helvetica", size: 8
#   pdf.text "Fund Number: 005-761 NPO", align: :right
#   pdf.text "PBO Number 930000749", align: :right
# end
#
# pdf.bounding_box([0,675], width: 260) do
#   pdf.font "Helvetica", size: 12
#   pdf.text "Mrs Enid Blyton"
#   pdf.text "The Square"
#   pdf.text "Wareham"
#   pdf.text "Dorset BH20 5EZ"
#   pdf.text "United Kingdom"
# end
#
# pdf.bounding_box([261,675], width: 260) do
#   pdf.text "Receipt Number: 133559", align: :right
#   pdf.text "Date: 24-09-2013", align: :right
#   pdf.text "Donor Number: 100230", align: :right
# end
#
# pdf.bounding_box([0,550], width: 523) do
#   pdf.table([["Donation Type", "Amount"], ["Cash", "R 600"], ["Cheque", "R     0"], ["Total", "R 600"]], width: 523) do |t|
#     t.before_rendering_page do |page|
#       page.column(-1).align =  :right
#       page.row(-1).style = :bold
#     end
#   end
# end

pdf.encrypt_document permissions: {modify_contents: false}
File.open("proto.pdf", "wb") { |f| f.write pdf.render }
