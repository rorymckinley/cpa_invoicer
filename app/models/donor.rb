class Donor < ActiveRecord::Base
  has_many :transactions

  def fullname
    (title.to_s + " " + initials.to_s + " " + surname.to_s).strip
  end

end
