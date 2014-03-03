require 'spec_helper'

describe "receipts/index" do
  before(:each) do
    @receipt1 = Receipt.create donor_name: "ABC", receipt_number: "123"
    @receipt2 = Receipt.create donor_name: "DEF", receipt_number: "456"
  end
  
  it "displays receipts" do
    assign(:receipts, [@receipt1, @receipt2])

    render

    rendered.should match /ABC/
    rendered.should match /123/
    rendered.should match /DEF/
    rendered.should match /456/
  end
  it "provides links that can be used to show the receipt" do
    assign(:receipts, [@receipt1, @receipt2])

    render

    rendered.should include receipt_path @receipt1
    rendered.should include receipt_path @receipt2
  end
end
