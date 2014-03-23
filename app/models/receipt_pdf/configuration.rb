module ReceiptPdf
  class Configuration
    def build_config(receipt)
      {
        donor_address: format_address(receipt.donor_address),
        donor_name: [receipt.donor_name],
        receipt_date: receipt.receipt_date,
        line_items: format_line_items(receipt.line_items),
        receipt_total: [format_as_money(total(receipt.line_items).to_s)],
        receipt_number: [receipt.receipt_number]
      }
    end

    def format_address(donor_address)
      donor_address.map { |line| [line] }
    end

    def format_line_items(line_items)
      line_items.map { |line| line.slice(0..1) << format_as_money(line.last) }
    end
    
    def total(line_items)
      line_items.inject(BigDecimal.new("0.00")) do |total, line_item|
        total + BigDecimal.new(line_item.last)
      end
    end

    def format_as_money(value)
      "R% 11.2f" % value
    end
  end
end
