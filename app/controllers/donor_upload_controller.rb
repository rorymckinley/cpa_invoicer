class DonorUploadController < ApplicationController
  def new
    @upload = DonorUpload.new
    @upload
  end

  def create
    @upload = DonorUpload.new
    @upload.process(params[:donor_upload][:contents])
    head 200
  end
end
