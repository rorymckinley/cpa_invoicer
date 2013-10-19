require "spec_helper"

describe "uploading donors" do
  before(:each) do
    Donor.delete_all
  end

  it "uploads donors" do
    file = Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'donors.csv'), 'text/csv')

    post "donor_upload", donor_upload: { contents: file }
    Donor.first.donor_no.should eql "100001"
    Donor.last.donor_no.should eql "100002"
  end

  it "uploads donors that have non-ASCII characters" do
    file = Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'donors_dodgy.csv'), 'text/csv')

    post "donor_upload", donor_upload: { contents: file }
    response.code.should eql "200"
    Donor.first.donor_no.should eql "102594"
  end
end
