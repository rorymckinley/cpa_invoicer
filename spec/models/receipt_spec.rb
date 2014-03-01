require "spec_helper"

describe Receipt do
  it "serializes the donor address data" do
    receipt = described_class.create! :donor_address => ["Stuff", "to", "serialise"]
    receipt.reload.donor_address.should eql ["Stuff", "to", "serialise"]
  end

  it "serialises the line items data" do
    receipt = described_class.create! :line_items => ["Stuff", "to", "serialise"]
    receipt.reload.line_items.should eql ["Stuff", "to", "serialise"]
  end

  it "returns the last receipts created" do
    for i in 0..4
      Receipt.create receipt_number: i
    end
    
    latest_4 = described_class.latest(4)
    latest_4.size.should eql 4
    latest_4.first.receipt_number.should eql "4"
    latest_4.last.receipt_number.should eql "1"
  end
end
