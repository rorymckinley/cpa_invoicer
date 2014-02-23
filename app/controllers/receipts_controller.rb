class ReceiptsController < ApplicationController
  def build
    (Transaction.unallocated.group_by { |t| t.donor }).each do |donor,transactions|
      transformer = TransactionReceiptTransformer.new
      receipt = transformer.transform(donor, transactions)

      transformer.persist_transformation(receipt, transactions)
    end
    
    head 200
  end
end
