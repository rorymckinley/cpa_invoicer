class Receipt < ActiveRecord::Base
  serialize :donor_address
  serialize :line_items

  def self.latest(n)
    order(id: :desc).limit(n)
  end
end
