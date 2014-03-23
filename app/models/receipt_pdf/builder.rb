module ReceiptPdf
  class Builder
    def build(pdf, config)
      pdf.font_families.update("LiberationMono" => {
        :normal => File.join(Rails.root, "lib", "prawn_support", "fonts", "LiberationMono-Regular.ttf"),
        :italic => File.join(Rails.root, "lib", "prawn_support", "fonts", "LiberationMono-Italic.ttf"),
        :bold => File.join(Rails.root, "lib", "prawn_support", "fonts", "LiberationMono-Bold.ttf"),
        :bold_italic => File.join(Rails.root, "lib", "prawn_support", "fonts", "LiberationMono-BoldItalic.ttf"),
      })
      pdf.font "LiberationMono", size: 10
      pdf.stroke_bounds
      top_edge = pdf.bounds.height
      pdf.bounding_box([0,top_edge], width: pdf.bounds.width, height:160) do
        pdf.bounding_box([0, 160], width: 205, height:160) do
          contact_details = [
                             ["Tel:", "021-535 3435"],
                             ["Fax:", "021-535 3434"],
                             ["Emergency:", "082 659 9599"],
                             ["Email:", "info@carthorse.org.za"]
                            ]
          pdf.pad(20) do
            pdf.table(contact_details, width: 205) do |table|
              table.cells.borders = []
              table.cells.padding = 4
            end
          end
        end
        pdf.bounding_box([205, 160], width: 113, height:120) do
          pdf.image File.join(Rails.root, "lib", "prawn_support", "chpa_logo_crop.jpg"), position: :center, width: 113
        end
        pdf.bounding_box([205, 40], width: 113, height:40) do
          pdf.pad(10) { pdf.text "005-761 NPO", align: :center }
        end

        pdf.bounding_box([318, 160], width: 205, height:160) do
          contact_details = [
                             ["92 Bofors Circle, Epping 2"],
                             ["PO Box 846, Eppindust, 7475"],
                             ["Cape Town, South Africa"],
                             ["www.carthorse.org.za"]
                            ]
          pdf.pad(20) do
            pdf.table(contact_details, width: 205) do |table|
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
        pdf.bounding_box([0,18], width: 120, height: 18) do
          pdf.table([["RECEIPT NO"]]) do |table|
            table.cells.borders = []
            table.cells.padding = 2
          end
        end
        pdf.bounding_box([120,18], width: 403.28, height: 18) do
          pdf.table([config[:receipt_number]], width:403.28) do |table|
            table.cells.borders = []
            table.cells.padding = 2
          end
          pdf.stroke_bounds
        end
        pdf.stroke_bounds
      end
      top_edge -= 18
      pdf.bounding_box([0,top_edge], width: pdf.bounds.width, height:18) do
        pdf.bounding_box([0,18], width: 120, height: 18) do
          pdf.table([["DONOR NAME"]]) do |table|
            table.cells.borders = []
            table.cells.padding = 2
          end
          pdf.stroke_bounds
        end
        pdf.bounding_box([120,18], width: 403.28, height: 18) do
          pdf.table([config[:donor_name]], width:403.28) do |table|
            table.cells.borders = []
            table.cells.padding = 2
          end
          pdf.stroke_bounds
        end
        pdf.stroke_bounds
      end
      top_edge -= 18
      pdf.bounding_box([0,top_edge], width: pdf.bounds.width, height:100) do
        pdf.bounding_box([0,100], width: 120, height: 100) do
          pdf.table([["ADDRESS OF DONOR"]]) do |table|
            table.cells.borders = []
            table.cells.padding = 2
          end
          pdf.stroke_bounds
        end
        pdf.bounding_box([120,100], width: 403.28, height: 100) do
          pdf.table(config[:donor_address]) do |table|
            table.cells.padding = 2
            table.cells.borders = []
          end
          pdf.stroke_bounds
        end
        pdf.stroke_bounds
      end
      top_edge -= 100
      pdf.bounding_box([0,top_edge], width: pdf.bounds.width, height:18) do
        pdf.bounding_box([0,18], width: 120, height: 18) do
          pdf.table([["AMOUNT OF DONATION"]]) do |table|
            table.cells.borders = []
            table.cells.padding = 2
          end
        end
        pdf.bounding_box([120,18], width: 403.28, height: 18) do
          pdf.table([config[:receipt_total]], width:403.28) do |table|
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
        pdf.bounding_box([0,290], width: 120, height: 290) do
          pdf.table([["NATURE OF DONATION"]]) do |table|
            table.cells.borders = []
            table.cells.padding = 2
          end
          pdf.stroke_bounds
        end
        pdf.bounding_box([120,290], width: 403.28, height: 290) do
          pdf.table(config[:line_items], width:403.28) do |table|
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
          pdf.image File.join(Rails.root, "lib", "prawn_support", "receipt_signature.jpg"), vposition: :bottom, position: :center, height: 40
        end
        pdf.bounding_box([0,18], width: 250, height: 18) do
          pdf.text "Title of signatory goes here", align: :center
        end
      end
      pdf.bounding_box([250,top_edge], width: 273, height:98) do
        pdf.bounding_box([0,98], width: 273, height: 80) do
          pdf.pad(60) do
            pdf.text "2014-01-20", align: :center
          end
        end
        pdf.bounding_box([0,18], width: 273, height: 18) do
          pdf.text "Date", align: :center
        end
      end

      pdf.encrypt_document permissions: {modify_contents: false}
      pdf.render
      
    end
  end
end
