class Transaction < ActiveRecord::Base
  belongs_to :motive
  belongs_to :donor

  def self.unallocated
    where(receipt_id: nil)
  end
end
