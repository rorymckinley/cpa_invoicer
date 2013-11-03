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

  it "passes the transaction data to the relevant model along with an instance of an upload date" do
    file = Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'transactions.csv'), 'text/csv')
    TransactionUploadDate.should_receive(:cutoff_date).and_return(date = double)
    @upload.should_receive(:process).with(file, date)

    post :create, transaction_upload: { contents: file }
  end
end
