require 'spec_helper'

describe "Showing the invoice as a PDF" do
  it "provides the invoice as a PDF" do
    receipt = Receipt.create receipt_number: "ABC123", donor_name: "John Smith",
                             donor_address: ["1 Nowhere Street", "Nowheresville"], line_items: [["Blah", "Blah", 100]]

    get "receipts/#{receipt.id}"
    response.should be_ok
    response.headers["Content-Type"].should eql "application/pdf"
    response.headers["Content-Disposition"].should eql "attachment"
  end
end
