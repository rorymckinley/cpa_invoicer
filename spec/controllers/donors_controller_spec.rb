require "spec_helper"

describe DonorsController do
  it "provides a search form" do
    Donor.stub(:new).and_return(donor = double(Donor))

    get :search_form
    assigns[:donor].should eql donor
  end

  it "allows searching by donor code" do
    Donor.should_receive(:where).with(donor_no: "1001").and_return([donor = double(Donor).as_null_object])

    get :index, donor: { donor_no: "1001"}
    assigns[:donor].should eql donor
  end
end
