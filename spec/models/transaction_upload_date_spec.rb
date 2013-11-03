require 'spec_helper'

describe TransactionUploadDate do
  it "returns a cutoff date" do
    TransactionUploadDate.cutoff_date.should eql Date.today - 1.year
  end
end
