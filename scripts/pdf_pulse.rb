require 'rubygems'
require 'bundler'

Bundler.setup

require 'prawn'
require 'prawn/measurement_extensions'


class Box
  def initialize(pdf, options)
    @pdf = pdf
    @position = options[:position]
    @dimensions = options[:dimensions]
  end

  def add_contents(contents)
    @contents = contents
  end

  def render
    @pdf.bounding_box(@position, @dimensions) do
      @contents.render
    end
  end
  
end

class Padding
  def initialize(pdf, options)
    @pdf = pdf
    @padding = options[:padding]
  end

  def add_contents(contents)
    @contents = contents
  end

  def render
    @pdf.pad(@padding) { @contents.render }
  end
end

class Table
  def initialize(pdf, options)
    @pdf = pdf
    @width = options[:width]
    @cell_borders = options[:cell][:borders]
    @cell_padding = options[:cell][:padding]
  end

  def add_contents(contents)
    @contents = contents
  end

  def render
    @pdf.table(@contents, width: @width) do |table|
      table.cells.borders = []
      table.cells.padding = @cell_padding
    end
  end
end
contact_details = [
                   ["Tel:", "021-535 3435"],
                   ["Fax:", "021-535 3434"],
                   ["Emergency:", "082 659 9599"],
                   ["Email", "info@carthorse.org.za"]
                  ]
config = { class: Box, options: { position: [0,160], dimensions: { width: 180, height: 160} }, content: { class: Padding, options: { padding: 20 }, content: { class: Table, options: { width: 180, cell: { borders: false, padding: 4 } }, content: contact_details  }}}

def builder(pdf, config)
  instance = config[:class].new pdf, config[:options]
  if config[:content].respond_to? :has_key? and config[:content].has_key? :class
    instance.add_contents builder(pdf, config[:content])
  else
    instance.add_contents config[:content]
  end
  instance
end

pdf = Prawn::Document.new(page_size:  "A4", page_layout: :portrait)
=begin
table = Table.new(pdf, width: 180, cell: { borders: false, padding: 4 })
table.add_contents contact_details

padding = Padding.new(pdf, 20)
padding.add_contents(table)

box = Box.new(pdf, [0,160], width: 180, height: 160)
box.add_contents padding
=end
box2 = builder(pdf, config)

pdf.stroke_bounds
top_edge = pdf.bounds.height
pdf.bounding_box([0,top_edge], width: pdf.bounds.width, height:160) do
  pdf.font "Helvetica", size: 10
  box2.render
=begin
  pdf.bounding_box([0, 160], width: 180, height:160) do
    pdf.font "Helvetica", size: 10
    contact_details = [
      ["Tel:", "021-535 3435"],
      ["Fax:", "021-535 3434"],
      ["Emergency:", "082 659 9599"],
      ["Email", "info@carthorse.org.za"]
    ]
    pdf.pad(20) do
      pdf.table(contact_details, width: 180) do |table|
        table.cells.borders = []
        table.cells.padding = 4
      end
    end
  end
=end
  pdf.bounding_box([180, 160], width: 160, height:120) do
    pdf.image "/home/rory/data/git/cpa_invoicer/scripts/chpa_logo_crop.jpg", position: :center, height: 120
  end
  pdf.bounding_box([180, 40], width: 160, height:40) do
    pdf.pad(10) { pdf.text "005-761 NPO", align: :center }
  end

  pdf.bounding_box([340, 160], width: 183, height:160) do
    pdf.font "Helvetica", size: 10
    contact_details = [
      ["92 Bofors Circle, Epping 2"],
      ["PO Box 846, Eppindust, 7475"],
      ["Cape Town, South Africa"],
      ["www.carthorse.org.za"]
    ]
    pdf.pad(20) do
      pdf.table(contact_details, width:183) do |table|
        table.cells.borders = []
        table.cells.padding = 4
        table.before_rendering_page do |page|
          page.column(-1).align =  :right
        end
      end
    end
  end
  pdf.stroke_bounds
end
top_edge -= 160
pdf.bounding_box([0,top_edge], width: pdf.bounds.width, height:50) do
  pdf.font "Helvetica", size: 10
  pdf.pad(5) do
    pdf.indent 2 do
      pdf.text "DONATION RECEIPT"
      pdf.text "Issued in terms of Section 18A of the Income Tax Act of 1962. The donation received below will be used exclusively for the objects of the Cart Horse Protection Association in carrying out PBAs approved in terms of section 18A."
    end
  end
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
    pdf.table([["R    5000.00"]], width:403.28) do |table|
      table.cells.borders = []
      table.cells.padding = 2
      table.cells.align = :right
    end
    pdf.stroke_bounds
  end
  pdf.stroke_bounds
end
top_edge -= 18
line_items = [
  ["100016", "ZERO TOLERANCE", "R      300.00"],
  ["100017", "ART AUCTION", "R      500.00"],
  ["100018", "SHOES", "R      400.00"],
  ["100019", "VET CARE", "R    1400.00"],
  ["100025", "BEQUEST", "R      400.00"],
  ["100028", "APRIL APPEAL", "R      400.00"],
  ["100029", "GOLF DAY", "R      400.00"],
  ["100018", "CORPORATE", "R      400.00"],
  ["100018", "FIRLANDS-STABLING", "R      400.00"],
  ["100018", "FOOT CARE PROJECT", "R      400.00"],
]
pdf.bounding_box([0,top_edge], width: pdf.bounds.width, height:290) do
  pdf.font "Helvetica", size: 10
  pdf.bounding_box([0,290], width: 120, height: 290) do
    pdf.table([["NATURE OF DONATION"]]) do |table|
      table.cells.borders = []
      table.cells.padding = 2
    end
    pdf.stroke_bounds
  end
  pdf.bounding_box([120,290], width: 403.28, height: 290) do
    pdf.table(line_items, width:403.28) do |table|
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
top_edge -= 290
pdf.bounding_box([0,top_edge], width: pdf.bounds.width, height:18) do
  pdf.font "Helvetica", size: 10
  pdf.bounding_box([0,18], width: 120, height: 18) do
    pdf.table([["PBO NUMBER"]]) do |table|
      table.cells.borders = []
      table.cells.padding = 2
    end
    pdf.stroke_bounds
  end
  pdf.bounding_box([120,18], width: 403.28, height: 18) do
    pdf.table([["930000749"]], width:403.28) do |table|
      table.cells.borders = []
      table.cells.padding = 2
    end
    pdf.stroke_bounds
  end
  pdf.stroke_bounds
end
top_edge -= 18
pdf.bounding_box([0,top_edge], width: 250, height:98) do
  pdf.bounding_box([0,98], width: 250, height: 80) do
    pdf.image "/home/rory/data/git/cpa_invoicer/scripts/receipt_signature.jpg", vposition: :bottom, position: :center, height: 40
  end
  pdf.bounding_box([0,18], width: 250, height: 18) do
    pdf.font "Helvetica", size: 10
    pdf.text "Title of signatory goes here", align: :center
  end
end
pdf.bounding_box([250,top_edge], width: 273, height:98) do
  pdf.bounding_box([0,98], width: 273, height: 80) do
    pdf.font "Helvetica", size: 10
    pdf.pad(60) do
      pdf.text "2014-01-20", align: :center
    end
  end
  pdf.bounding_box([0,18], width: 273, height: 18) do
    pdf.font "Helvetica", size: 10
    pdf.text "Date", align: :center
  end
end
# pdf.stroke_axis
puts pdf.bounds.width
puts pdf.bounds.height

pdf.encrypt_document permissions: {modify_contents: false}
File.open("proto.pdf", "wb") { |f| f.write pdf.render }
