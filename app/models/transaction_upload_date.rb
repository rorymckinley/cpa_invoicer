class TransactionUploadDate
  def self.cutoff_date
    Date.today - 1.year
  end
end
