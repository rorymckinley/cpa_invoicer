class TransactionUploadsController < ApplicationController
  def new
    @upload = TransactionUpload.new
  end

  def create
    @upload = TransactionUpload.new
    @upload.process params[:transaction_upload][:contents], TransactionUploadDate.cutoff_date

    @exclusions = @upload.exclusions
  end
end
