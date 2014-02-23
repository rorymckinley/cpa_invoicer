require 'spec_helper'

describe DonorUpload do
  subject { described_class.new }
  let(:contents) do
    "#{contents_header}\n#{contents_record}"
  end
  let(:contents_header) do
    "DONOR_NO,TITLE,INITIALS,SURNAME,Email,ADDR1,ADDR2,TOWN,PCODE"
  end
  let(:contents_record) do
    "1001,2,John,Smith,john@smith.test,1 Nonsense Road,Monkey Town,Cape Town,7550"
  end
  let(:donor) { double(Donor) }
  let(:io) {double(IO, read: contents) }
  let(:title) { double(Title, description: "Mr") }

  before(:each) do
    Donor.stub(:where).and_return([])
  end

  it "creates a donor entry for each record provided by the IO object - excluding headers" do
    attributes = {donor_no: "1001", initials: "John", surname: "Smith", title: "Mr",
      email: "john@smith.test", address1: "1 Nonsense Road", address2: "Monkey Town",
      town: "Cape Town", postal_code: "7550"}

    Title.should_receive(:where).with(number: "2").and_return([title])
    Donor.should_receive(:create).with(attributes)

    subject.process(io)
  end

  it "excludes a donor entry if the record does not have initials or a surname" do
    io = double(IO, read: "DONOR_NO,INITIALS,SURNAME\n1001,,")
    Donor.should_not_receive(:create)

    subject.process(io)
  end

  it "updates a donor entry if the entry already exists" do
    attributes = {donor_no: "1001", initials: "John", surname: "Smith", title: "Mr",
      email: "john@smith.test", address1: "1 Nonsense Road", address2: "Monkey Town",
      town: "Cape Town", postal_code: "7550"}
    Title.stub(:where).and_return([title])
    Donor.should_receive(:where).with(donor_no: "1001").and_return([donor])
    donor.should_receive(:update_attributes).with(attributes)

    subject.process(io)
  end

  it "raises an error if it cannot find a title entry for the record" do
    Title.stub(:where).and_return([])

    expect { subject.process io }.to raise_error "No title found for donor 1001"
  end
end
