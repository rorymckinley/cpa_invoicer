class TransactionsController < ApplicationController
  def search_form
    @transaction = Transaction.new
  end

  def search
    @transaction = Transaction.where(receipt_number: params[:transaction][:receipt_number]).first
  end
end
