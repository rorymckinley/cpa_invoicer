require "spec_helper"

describe ReceiptPdfGenerator do
  subject { described_class.new }
  before(:each) do
    @builder = double(ReceiptPdf::Builder, build: "This is my PDF content")
    ReceiptPdf::Builder.stub(:new).and_return(@builder)
    @config_data = {}
    @config = double(ReceiptPdf::Configuration, build_config: @config_data)
    @pdf = double(Prawn::Document)
    Prawn::Document.stub(:new).and_return(@pdf)
    ReceiptPdf::Configuration.stub(:new).and_return(@config)
    @receipt = double(Receipt)

    @invoice_date = "2014-01-20"
  end

  it "generates pdf configuration data based on the receipt and invoice_date" do
    @config.should_receive(:build_config).with(@receipt, Date.parse(@invoice_date))
    
    subject.generate(@receipt, @invoice_date)
  end

  it "defaults the invoice date to today if no date is passed in" do
    @config.should_receive(:build_config).with(@receipt, Date.today)

    subject.generate(@receipt, nil)
  end

  it "creates a Prawn document instance" do
    Prawn::Document.should_receive(:new).with(page_size: "A4", page_layout: :portrait)

    subject.generate(@receipt, @invoice_date)
  end

  it "passes the config and pdf instance to the builder" do
    @builder.should_receive(:build).with(@pdf, @config_data)

    subject.generate(@receipt, @invoice_date)
  end

  it "returns the rendered pdf content" do
    subject.generate(@receipt, @invoice_date).should eql "This is my PDF content"
  end
    
end
