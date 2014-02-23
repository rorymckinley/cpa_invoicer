class Transaction < ActiveRecord::Base
  belongs_to :motive
  belongs_to :donor

  def self.unallocated
    where(receipt_id: nil)
  end

  def reference_number
    receipt_number
  end

  def description
    motive.description
  end
end
