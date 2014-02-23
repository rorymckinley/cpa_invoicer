class TransactionReceiptTransformer
  def transform(donor, transactions)
    Receipt.new receipt_number: generate_receipt_number(donor), donor_name: donor.fullname, donor_address: generate_address(donor), line_items: generate_line_items(transactions)
  end

  def generate_receipt_number(donor)
    "#{donor.donor_no}-#{Time.now.strftime("%Y%m%d")}"
  end
  private :generate_receipt_number

  def generate_address(donor)
    [donor.address1, donor.address2, donor.town, donor.postal_code, donor.email]
  end
  private :generate_address

  def generate_line_items(transactions)
    transactions.inject([]) do |memo,t|
      memo << [t.reference_number, t.description, t.amount]
    end
  end
  private :generate_line_items

  def persist_transformation(receipt, transactions)
    ActiveRecord::Base.transaction do
      receipt.save!
      transactions.each { |t| t.update_attributes receipt_id: receipt.id }      
    end
  end
end
