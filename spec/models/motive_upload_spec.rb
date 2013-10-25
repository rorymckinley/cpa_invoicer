require "spec_helper"

describe MotiveUpload do
  subject { described_class.new }
  let(:contents) { %Q{"NUMBER,N,6,0","DESCRIP,C,25"\n1,ZERO TOLERANCE} }
  let(:io) { double(IO, read: contents) }
  let(:motive) { double(Motive) }

  it "creates motives for each record in the upload file" do
    Motive.should_receive(:create).with(number: "1", description: "ZERO TOLERANCE")

    subject.process(io)
  end

  it "updates an existing motive" do
    Motive.should_receive(:where).with(number: 1).and_return([motive])
    motive.should_receive(:update_attributes).with(number: 1, description: "ZERO TOLERANCE")

    subject.process(io)
  end
end
