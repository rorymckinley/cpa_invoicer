require 'spec_helper'

describe TitleUpload do
  subject { described_class.new }

  before(:each) do
    Title.stub(:create)
    Title.stub(:where).and_return([])
  end

  it "parses the input and creates titles" do
    contents = %Q{"NUMBER,N,3,0","DESCRIP,C,20","INDICATOR,L"\n2,MR,}
    io = double(IO, read: contents)

    Title.should_receive(:create).with(number: "2", description: "MR")

    subject.process(io)
  end

  it "updates the title if there is an existing title with the same number" do
    contents = %Q{"NUMBER,N,3,0","DESCRIP,C,20","INDICATOR,L"\n2,MR,}
    io = double(IO, read: contents)
    Title.should_receive(:where).with(number: "2").and_return([title = double(Title)])
    title.should_receive(:update_attributes).with(description: "MR")

    subject.process(io)
  end
end
