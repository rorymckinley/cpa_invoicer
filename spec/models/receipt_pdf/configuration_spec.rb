require "spec_helper"

describe ReceiptPdf::Configuration do
  subject { described_class.new }

  before(:each) do
    @receipt = Receipt.new receipt_number: "A1234", donor_name: "John Smith", donor_address: ["this", "is", "my", "address"],
                           line_items: [["a","b",BigDecimal.new("100.34").to_s],["c","d",BigDecimal.new("57.13").to_s]],
                           receipt_date: Date.new(2014,1,1)
    @config = subject.build_config(@receipt)
  end

  describe "the config" do
    it "includes the donor name" do
      @config[:donor_name].should eql [@receipt.donor_name]
    end
    it "includes the receipt_number" do
      @config[:receipt_number].should eql [@receipt.receipt_number]
    end
    it "includes the receipt date" do
      @config[:receipt_date].should eql @receipt.receipt_date
    end
    it "includes the receipt total" do
      @config[:receipt_total].should eql ["R     157.47"]
    end
    it "includes the donor's address" do
      @config[:donor_address].should eql [
                                          [@receipt.donor_address[0]],
                                          [@receipt.donor_address[1]],
                                          [@receipt.donor_address[2]],
                                          [@receipt.donor_address[3]]
                                         ]
    end
    it "includes the receipt line items" do
      @config[:line_items].should eql [
                                       ["a","b","R     100.34"],
                                       ["c","d","R      57.13"]
                                      ]
    end
  end
  it "returns config data for the header" do
    config = subject.build_config(@receipt)
    config.should eql({ donor_name: @receipt.donor_name, donor_address: @receipt.donor_address,
                        receipt_date: @receipt.receipt_date, line_items: @receipt.line_items,
                        receipt_total: BigDecimal.new("157.47").to_s, receipt_number: @receipt.receipt_number })
  end
end
