require 'spec_helper'

describe "receipts/index" do
  it "displays invoices" do
    assign(:receipts, [double(Receipt, donor_name: "ABC", receipt_number: "123"), double(Receipt, donor_name: "DEF", receipt_number: "456")])

    render

    rendered.should match /ABC/
    rendered.should match /123/
    rendered.should match /DEF/
    rendered.should match /456/
  end
end
