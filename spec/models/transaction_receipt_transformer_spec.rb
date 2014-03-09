require 'spec_helper'

describe TransactionReceiptTransformer do

  subject { described_class.new }

  let(:donor) do
    double(Donor, donor_no: 19191, fullname: "Mr Full Name", address1: "1 Nonsense Road",
           address2: "Monkey Town", town: "Cape Town", postal_code: "7550", email: "john@smith.test")
  end
  let(:transaction_1) { double(Transaction, reference_number: "101", description: "Blah", amount: BigDecimal.new("100.43") ) }
  let(:transaction_2) { double(Transaction, reference_number: "105", description: "Bleh", amount: BigDecimal.new("200.13") ) }

  it "builds a receipt from a donor and transactions" do
    receipt = subject.transform(donor, [transaction_1,transaction_2])

    receipt.receipt_number.should eql "#{donor.donor_no}-#{Time.now.strftime("%Y%m%d")}"
    receipt.donor_name.should eql donor.fullname
    receipt.donor_address.should eql [donor.address1, donor.address2, donor.town, donor.postal_code, donor.email]
    receipt.line_items.should eql [
                                   ["101", "Blah", BigDecimal.new("100.43").to_s],
                                   ["105", "Bleh", BigDecimal.new("200.13").to_s]
                                  ]
  end

  context "persisting transformed receipts and transactions" do
    before(:each) do
      @receipt = Receipt.new receipt_number: rand(1000000000).to_s
      @transaction = Transaction.create!
    end

    it "saves the receipt" do
      subject.persist_transformation @receipt, [@transaction]

      Receipt.first.receipt_number.should eql @receipt.receipt_number
    end

    it "updates the transactions to link them to the receipt created" do
      subject.persist_transformation @receipt, [@transaction]

      @transaction.reload.receipt_id.should eql Receipt.first.id
    end

    it "rolls back changes to the receipt if updating a transaction fails" do
      @transaction.stub(:update_attributes).and_raise(RuntimeError)
      
      expect{subject.persist_transformation @receipt, [@transaction]}.to raise_error
      
      Receipt.first.should be_nil
    end
  end
end
