require 'spec_helper'

describe Donor do
  it "provides a collection of transactions" do
    d = Donor.create donor_no: "12345", surname: "Jones"
    t1 = Transaction.create receipt_number: "1001", donor_id: d.id
    t2 = Transaction.create receipt_number: "1002", donor_id: d.id

    d.reload.transactions.to_a.should eql [t1,t2]
  end
end
