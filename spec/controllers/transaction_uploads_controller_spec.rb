require "spec_helper"

describe TransactionUploadsController do
  render_views
  before(:each) do
    @upload = TransactionUpload.new
    TransactionUpload.stub(:new).and_return(@upload)
  end

  it "provides a form for uploading transactions" do
    get :new
    response.should be_ok
    assigns[:upload].should eql @upload
  end

  it "passes the transaction data to the relevant model" do
    file = Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'transactions.csv'), 'text/csv')
    @upload.should_receive(:process).with(file)

    post :create, transaction_upload: { contents: file }
  end
end
