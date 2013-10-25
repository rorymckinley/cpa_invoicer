class MotiveUploadsController < ApplicationController
  def new
    @upload = MotiveUpload.new
  end

  def create
    @upload = MotiveUpload.new
    @upload.process(params[:motive_upload][:contents])

    head 200
  end
end
