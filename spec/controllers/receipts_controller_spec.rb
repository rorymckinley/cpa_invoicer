require 'spec_helper'

describe ReceiptsController do
  render_views
  let(:donor_1) { double(Donor) }
  let(:donor_2) { double(Donor) }
  let(:receipt) { double(Receipt) }

  let(:transaction_1) { double(Transaction, donor: donor_1) }
  let(:transaction_2) { double(Transaction, donor: donor_1) }
  let(:transaction_3) { double(Transaction, donor: donor_2) }
  let(:trr) { double(TransactionReceiptTransformer, persist_transformation: true, transform: receipt) }
  before(:each) do
    Transaction.stub(:unallocated).and_return([transaction_1, transaction_2, transaction_3])
    TransactionReceiptTransformer.stub(:new).and_return(trr)
  end

  context "#build_form" do
    let(:transaction) { double(Transaction).as_null_object }
    
    it "gets a list of unallocated transactions" do
      Transaction.should_receive(:unallocated).and_return([transaction])

      get :build_form
    end

    it "passes the unallocated transactions to the view" do
      Transaction.stub(:unallocated).and_return([transaction])

      get :build_form
      
      assigns[:transactions].should eql [transaction]
    end
  end
  context "#build" do
    it "builds receipts from unallocated transactions" do
      trr.should_receive(:transform).with(donor_1, [transaction_1, transaction_2])
      trr.should_receive(:transform).with(donor_2, [transaction_3])

      post :build
    end

    it "persists any receipts that were created" do
      Transaction.stub(:unallocated).and_return([transaction_3])
      trr.stub(:transform).and_return(receipt)

      trr.should_receive(:persist_transformation).with(receipt, [transaction_3])
      
      post :build
    end

    it "redirects to the receipt listing page" do
      post :build

      response.should redirect_to protocol: "https://", controller: "receipts", action: "index"
    end  
  end

  context "#index" do
    let(:collection) { [] }
    it "lists the last thirty receipts created" do
      Receipt.should_receive(:latest).with(30).and_return(collection)

      get :index
    end

    it "passes the latest receipts to the template" do
      Receipt.stub(:latest).and_return(collection)

      get :index
      assigns[:receipts].should eql collection
    end
  end

  context "#show" do
    before(:each) do
      @generator = ReceiptPdfGenerator.new
      @invoice_date = "2014-01-20"
      ReceiptPdfGenerator.stub(:new).and_return(@generator)
    end
    
    it "generates a pdf version of the requested invoice" do
      Receipt.should_receive(:find).with(999666).and_return(receipt)
      @generator.should_receive(:generate).with(receipt)

      get :show, id: 999666
    end

    it "returns the generated pdf" do
      Receipt.stub(:find).and_return(receipt)
      @generator.stub(:generate).and_return("pretending to be pdf data")

      get :show, id: 999666
      
      response.body.should eql "pretending to be pdf data"
      response.headers["Content-Type"].should eql "application/pdf"
    end
  end
end
