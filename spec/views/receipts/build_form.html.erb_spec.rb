require "spec_helper"

describe "receipts/build_form" do
  let(:donor_1) { double(Donor, fullname: "John Smith") }
  let(:donor_2) { double(Donor, fullname: "Jane Smith") }
  let(:transaction_1) { double(Transaction, receipt_number: "001", donor: donor_1, receipt_date: "2014-02-01") }
  let(:transaction_2) { double(Transaction, receipt_number: "002", donor: donor_2, receipt_date: "2014-02-02") }
                             
  it "displays a list of transactions" do
    assign(:transactions, [transaction_1, transaction_2])

    render

    rendered.should match /Jane Smith/
    rendered.should match /John Smith/
    rendered.should match /001/
    rendered.should match /002/
    rendered.should match /2014-02-01/
    rendered.should match /2014-02-02/
    
  end

  it "can be used to trigger a receipt building process" do
    assign(:transactions, [])

    render

    rendered.should match /action="\/receipts\/build"/
  end
end
