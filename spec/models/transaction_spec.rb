require "spec_helper"

describe Transaction do
  before(:each) do
    @motive = Motive.create!
    @donor = Donor.create!
    @transaction = Transaction.create! donor_id: @donor.id, motive_id: @motive.id
  end

  it "is associated with a motive" do
    @transaction.motive.should eql @motive
  end

  it "is associated with a donor" do
    @transaction.donor.should eql @donor
  end
end
