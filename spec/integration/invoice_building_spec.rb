require 'spec_helper'

describe "building receipts from unallocated transactions" do
  it "allocates unallocated transactions to receipts" do
    Receipt.delete_all

    donor = Donor.create title: "Mr", initials: "John", surname: "Smith"
    motive = Motive.create description: "stuff"
    transaction = Transaction.create receipt_number: "1234", donor_id: donor.id, motive_id: motive.id, amount: 100.00

    post "receipts/build"
    receipt = Receipt.first

    receipt.donor_name.should eql donor.fullname
    receipt.line_items.should eql [[transaction.reference_number, transaction.description, transaction.amount]]
  end
end
