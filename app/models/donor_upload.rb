require 'csv'

class DonorUpload
  include ActiveModel::Model
  attr_reader :contents

  def process(io)
    contents = io.read.force_encoding("UTF-8").encode
    CSV.parse(contents, headers: true) do |record|
      next if record["INITIALS"].nil? and record["SURNAME"].nil?

      title = Title.where(number: record["TITLE"]).first

      raise "No title found for donor #{record["DONOR_NO"]}" unless title

      if donor = Donor.where(donor_no: record["DONOR_NO"]).first
        donor.update_attributes(donor_no: record["DONOR_NO"], initials: record["INITIALS"], surname: record["SURNAME"], title: title.description)
      else
        Donor.create(donor_no: record["DONOR_NO"], initials: record["INITIALS"], surname: record["SURNAME"], title: title.description)
      end
    end
  end
end
