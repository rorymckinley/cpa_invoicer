class Transaction < ActiveRecord::Base
  belongs_to :motive
  belongs_to :donor
end
