require "spec_helper"

describe Transaction do
  let(:donor) { Donor.create! }
  let(:motive) { Motive.create! }
  let(:receipt) { Receipt.create! }
  let(:allocated_transaction) { Transaction.create! donor_id: donor.id, motive_id: motive.id, receipt_id: receipt.id }
  let(:transaction) { Transaction.create! donor_id: donor.id, motive_id: motive.id }

  it "is associated with a motive" do
    transaction.motive.should eql motive
  end

  it "is associated with a donor" do
    transaction.donor.should eql donor
  end

  it "lists all transactions that are not allocated to a receipt" do
    Transaction.unallocated.should match_array [transaction]
  end
end
