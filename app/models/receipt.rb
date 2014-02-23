class Receipt < ActiveRecord::Base
  serialize :donor_address
  serialize :line_items
end
