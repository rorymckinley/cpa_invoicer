class Donor < ActiveRecord::Base
  has_many :transactions
end
