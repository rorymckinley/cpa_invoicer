require 'spec_helper'

describe MotiveUploadsController do
  render_views
  before(:each) do
    @upload = MotiveUpload.new
    MotiveUpload.stub(:new).and_return(@upload)
  end

  it "provides a form for uploading of motives" do
    get :new
    response.should be_ok
    assigns[:upload].should eql @upload
  end

  it "passes the uploaded file to the MotiveUpload instance" do
    file = Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'motives.csv'), 'text/csv')
    @upload.should_receive(:process).with(file)

    post :create, motive_upload: { contents: file }

    response.should be_ok
  end
end
