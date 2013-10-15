require 'spec_helper'

describe DonorUploadController do
  render_views
  let(:upload) { DonorUpload.new }

  before(:each) do
    @upload = DonorUpload.new
    DonorUpload.stub(:new).and_return(@upload)
  end

  it "presents the user with a way to import donors" do
    get :new
    assigns[:upload].should eql @upload
    response.should be_ok
  end

  it "passes submitted upload data to the DonorUpload instance" do
    file = Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'donors.csv'), 'text/csv')
    @upload.should_receive(:process).with(file)

    post :create, donor_upload: { contents: file }

    response.should be_ok
  end
end
