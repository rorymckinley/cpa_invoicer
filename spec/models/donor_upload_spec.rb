require 'spec_helper'

describe DonorUpload do
  subject { described_class.new }
  let(:donor) { double(Donor) }

  before(:each) do
    Donor.stub(:where).and_return([])
  end

  it "creates a donor entry for each record provided by the IO object - excluding headers" do
    io = double(IO, read: "DONOR_NO,INITIALS,SURNAME\n1001,John,Smith")
    Donor.should_receive(:create).with(donor_no: "1001", initials: "John", surname: "Smith")

    subject.process(io)
  end

  it "excludes a donor entry if the record does not have initials or a surname" do
    io = double(IO, read: "DONOR_NO,INITIALS,SURNAME\n1001,,")
    Donor.should_not_receive(:create)

    subject.process(io)
  end

  it "updates a donor entry if the entry already exists" do
    io = double(IO, read: "DONOR_NO,INITIALS,SURNAME\n1001,John,Smith")
    Donor.should_receive(:where).with(donor_no: "1001").and_return([donor])
    donor.should_receive(:update_attributes).with(donor_no: "1001", initials: "John", surname: "Smith")

    subject.process(io)
  end
end
