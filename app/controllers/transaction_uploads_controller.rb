class TransactionUploadsController < ApplicationController
  def new
    @upload = TransactionUpload.new
  end

  def create
    @upload = TransactionUpload.new
    @upload.process params[:transaction_upload][:contents], TransactionUploadDate.cutoff_date
    head 200
  end
end
