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
end
