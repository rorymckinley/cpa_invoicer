require "spec_helper"

describe TitleUploadsController do
  render_views
  before(:each) do
    @upload = TitleUpload.new
    TitleUpload.stub(:new).and_return(@upload)
  end

  it "provides a form for the uploading of titles" do
    get :new
    response.should be_ok
    assigns[:upload].should eql @upload
  end

  it "passes the uploaded file to the TitleUpload instance" do
    file = Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'titles.csv'), 'text/csv')
    @upload.should_receive(:process).with(file)

    post :create, title_upload: { contents: file }

    response.should be_ok
  end
end
