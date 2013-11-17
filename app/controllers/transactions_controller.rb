class TransactionsController < ApplicationController
  def search_form
    @transaction = Transaction.new
  end
end
