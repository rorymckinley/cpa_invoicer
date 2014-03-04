class ReceiptsController < ApplicationController
  def build_form
    @transactions = Transaction.unallocated
  end
  
  def build
    (Transaction.unallocated.group_by { |t| t.donor }).each do |donor,transactions|
      transformer = TransactionReceiptTransformer.new
      receipt = transformer.transform(donor, transactions)

      transformer.persist_transformation(receipt, transactions)
    end

    redirect_to protocol: "https://", controller: "receipts", action: "index"
  end

  def index
    @receipts = Receipt.latest(30)
  end

  def show
    receipt = Receipt.find(params[:id].to_i)
    ReceiptPdfGenerator.new.generate(receipt)
    
    head 200
  end
end


