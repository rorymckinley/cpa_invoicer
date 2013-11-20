require 'spec_helper'

describe TransactionsController do
  render_views

  it "provides a search form" do
    @transaction = Transaction.new
    Transaction.should_receive(:new).and_return(@transaction)

    get :search_form
    assigns[:transaction].should eql @transaction
  end

  it "searches for a transaction" do
    Transaction.should_receive(:where).with(receipt_number: "999").and_return([transaction = double(Transaction).as_null_object])

    post :search, transaction: { receipt_number: "999" }
    assigns[:transaction].should eql transaction
  end
end
