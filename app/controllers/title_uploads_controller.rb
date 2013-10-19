class TitleUploadsController < ApplicationController
  def new
    @upload = TitleUpload.new
  end

  def create
    @upload = TitleUpload.new
    @upload.process(params[:title_upload][:contents])
    head 200
  end
end
