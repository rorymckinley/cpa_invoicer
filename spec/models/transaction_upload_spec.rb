require 'spec_helper'

describe TransactionUpload do
  let(:contents) do
    "T_index,DONOR_NO,RCPT_NO,TRAN_TYPE,DATE,AMOUNT,MOTIVE,THANK_LET,CATEGORY\n45017,103852,133541,R,9/17/2013,77,65,FALSE"
  end
  let(:date) { double.as_null_object }
  let(:donor) { double.as_null_object }
  let(:io) { double(IO, read: contents) }
  let(:motive) { double.as_null_object }
  let(:transaction_attributes) do
    {receipt_number: "133541", donor_id: donor.id, motive_id: motive.id, receipt_date: date, amount: 77}
  end
  subject { described_class.new }

  before(:each) do
    Donor.stub(:where).and_return([donor])
    Motive.stub(:where).and_return([motive])
    Date.stub(:strptime).and_return(date)
  end

  it "creates a transaction for every record in the file" do
    Donor.should_receive(:where).with(donor_no: "103852").and_return([donor])
    Motive.should_receive(:where).with(number: "65").and_return([motive])
    Date.should_receive(:strptime).with("9/17/2013", "%m/%d/%Y").and_return(date)
    Transaction.should_receive(:create).with(transaction_attributes)

    subject.process(io)
  end

  it "updates any existing transactions found in the file" do
    Transaction.should_receive(:where).with(receipt_number: "133541").and_return([transaction = double])
    transaction.should_receive(:update_attributes).with(transaction_attributes)

    subject.process(io)
  end

  it "raises an error if no donor can be found for the transaction" do
    Donor.should_receive(:where).and_return([])

    expect { subject.process io }.to raise_error "No donor found"
  end

  it "raises an error if no motive can  be found" do
    Motive.should_receive(:where).and_return([])

    expect { subject.process io }.to raise_error "No motive found"
  end
end
