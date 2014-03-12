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
                                          ["100019", "VET CARE", "1400.00"],
                                          ["100025", "BEQUEST", "400.00"],
                                          ["100028", "APRIL APPEAL", "400.00"],
                                          ["100029", "GOLF DAY", "400.00"],
                                          ["100018", "CORPORATE", "400.00"],
                                          ["100018", "FIRLANDS-STABLING", "400.00"],
                                          ["100018", "FOOT CARE PROJECT", "400.00"]
                                         ]

    get "receipts/#{receipt.id}", invoice_date: "2014-01-20"
    response.should be_ok
    response.headers["Content-Type"].should eql "application/pdf"
    response.headers["Content-Disposition"].should eql "attachment"
    Digest::MD5.hexdigest(response.body).should eql reference_hash

  end
end
