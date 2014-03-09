require 'spec_helper'
require 'digest/md5'

describe "Showing the invoice as a PDF" do
  it "provides the invoice as a PDF" do
    reference_hash = Digest::MD5.hexdigest(IO.read(File.join(Rails.root, 'spec', 'fixtures', 'pdf', 'sample.pdf')))
    receipt = Receipt.create receipt_number: "10230-20140103", donor_name: "Mr Fred Flintstone",
                             donor_address: ["345 Cave Stone Road", "Sonstraal Heights", "Durbanville", "7550", "thecave@flintstone.co.za"],
                             line_items: [
                                          ["100016", "ZERO TOLERANCE", "300.00"],
                                          ["100017", "ART AUCTION", "500.00"],
                                          ["100018", "SHOES", "400.00"],
                                          ["100019", "VET CARE", ]
                                         ]

    get "receipts/#{receipt.id}"
    response.should be_ok
    response.headers["Content-Type"].should eql "application/pdf"
    response.headers["Content-Disposition"].should eql "attachment"
    Digest::MD5.hexdigest(response.body).should eql reference_hash

  end
end
