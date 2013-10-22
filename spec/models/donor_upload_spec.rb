require 'spec_helper'

describe DonorUpload do
  subject { described_class.new }
  let(:contents) { "DONOR_NO,TITLE,INITIALS,SURNAME\n1001,2,John,Smith" }
  let(:donor) { double(Donor) }
  let(:io) {double(IO, read: contents) }
  let(:title) { double(Title, description: "Mr") }

  before(:each) do
    Donor.stub(:where).and_return([])
  end

  it "creates a donor entry for each record provided by the IO object - excluding headers" do
    Title.should_receive(:where).with(number: "2").and_return([title])
    Donor.should_receive(:create).with(donor_no: "1001", initials: "John", surname: "Smith", title: "Mr")

    subject.process(io)
  end

  it "excludes a donor entry if the record does not have initials or a surname" do
    io = double(IO, read: "DONOR_NO,INITIALS,SURNAME\n1001,,")
    Donor.should_not_receive(:create)

    subject.process(io)
  end

  it "updates a donor entry if the entry already exists" do
    Title.stub(:where).and_return([title])
    Donor.should_receive(:where).with(donor_no: "1001").and_return([donor])
    donor.should_receive(:update_attributes).with(donor_no: "1001", initials: "John", surname: "Smith", title: "Mr")

    subject.process(io)
  end

  it "raises an error if it cannot find a title entry for the record" do
    Title.stub(:where).and_return([])

    expect { subject.process io }.to raise_error "No title found for donor 1001"
  end
end
