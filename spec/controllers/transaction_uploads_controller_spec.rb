require "spec_helper"

describe TransactionUploadsController do
  before(:each) do
    @upload = TransactionUpload.new
    TransactionUpload.stub(:new).and_return(@upload)
  end

  it "provides a form for uploading transactions" do
    get :new
    response.should be_ok
    assigns[:upload].should eql @upload
    response.should render_template :new
  end

  describe "#create" do
    let(:file) { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'transactions.csv'), 'text/csv') }
    before(:each) do
      @upload.stub(:process)
      @upload.stub(:exclusions).and_return(["all", "the", "things"])
    end

    it "passes the transaction data to the relevant model along with an instance of an upload date" do
      TransactionUploadDate.should_receive(:cutoff_date).and_return(date = double)
      @upload.should_receive(:process).with(file, date)

      post :create, transaction_upload: { contents: file }
    end

    it "lists any import exclusions when the upload is completed" do
      post :create, transaction_upload: { contents: file }

      assigns[:exclusions].should eql @upload.exclusions
      response.should render_template(:create)
    end
  end
end
