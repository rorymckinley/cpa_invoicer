require "spec_helper"

describe "Uploading transactions" do
  before(:each) do
   [103852,100761,100095].each { |num| Donor.create donor_no: num }
   [65,87,12].each { |num| Motive.create number: num }
  end
  it "uploads transactions" do
    file = Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'transactions.csv'), 'text/csv')

    post "transaction_uploads", transaction_upload: { contents: file }

    Transaction.count.should eql 3
  end
end
