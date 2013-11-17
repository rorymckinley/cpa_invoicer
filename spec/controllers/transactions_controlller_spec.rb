require 'spec_helper'

describe TransactionsController do
  integrate_views

  it "provides a search form" do
    @transaction = Transaction.new
    Transaction.should_receive(:new).and_return(@transaction)

    get :search_form
    assigns[:transaction].should eql @transaction
  end
end
