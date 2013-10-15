require 'csv'

class DonorUpload
  include ActiveModel::Model
  attr_reader :contents

  def process(io)
    CSV.parse(io.read, headers: true) do |record|
      next if record["INITIALS"].nil? and record["SURNAME"].nil?

      if donor = Donor.where(donor_no: record["DONOR_NO"]).first
        donor.update_attributes(donor_no: record["DONOR_NO"], initials: record["INITIALS"], surname: record["SURNAME"])
      else
        Donor.create(donor_no: record["DONOR_NO"], initials: record["INITIALS"], surname: record["SURNAME"])
      end
    end
  end
end
